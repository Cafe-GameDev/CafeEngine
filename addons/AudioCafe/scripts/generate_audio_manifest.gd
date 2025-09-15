@tool
extends EditorScript
signal progress_updated(current: int, total: int)
signal generation_finished(success: bool, message: String)

const MANIFEST_SAVE_PATH = "res://addons/AudioCafe/resources/audio_manifest.tres"

var _total_files_to_scan = 0
var _files_scanned = 0

@export var audio_config: AudioConfig = preload("res://addons/AudioCafe/resources/audio_config.tres")

func _run():
	_total_files_to_scan = 0
	_files_scanned = 0

	# Primeiro, conta o total de arquivos para o progresso
	for path in audio_config.sfx_paths:
		_count_files_in_directory(path)
	for path in audio_config.music_paths:
		_count_files_in_directory(path)

	print("Generating AudioManifest...")
	
	var audio_manifest = AudioManifest.new()
	var success = true
	var message = ""

	for path in audio_config.sfx_paths:
		if not _scan_and_populate_library(path, audio_manifest.sfx_data, "sfx"):
			success = false
			message = "Falha ao escanear caminhos SFX."
			break
		if not success:
			break

	for path in audio_config.music_paths:
		if not _scan_and_populate_library(path, audio_manifest.music_data, "music"):
			success = false
			message = "Falha ao escanear caminhos de Música."
			break
		if not success:
			break
	
	if success:
		var error = ResourceSaver.save(audio_manifest, MANIFEST_SAVE_PATH)
		if error != OK:
			success = false
			message = "Falha ao salvar AudioManifest.tres: %s" % error
		else:
			print("AudioManifest generated and saved to: %s" % MANIFEST_SAVE_PATH)

	emit_signal("generation_finished", success, message)

func _count_files_in_directory(current_path: String):
	print("Counting files in: ", current_path)
	var dir = DirAccess.open(current_path)
	if not dir:
		printerr("Failed to open directory for counting: %s" % current_path)
		return

	dir.list_dir_begin()
	var file_or_dir_name = dir.get_next()
	while file_or_dir_name != "":
		if dir.current_is_dir():
			_count_files_in_directory(current_path.path_join(file_or_dir_name))
		elif file_or_dir_name.ends_with(".ogg") or file_or_dir_name.ends_with(".wav"):
			_total_files_to_scan += 1
		file_or_dir_name = dir.get_next()

const PLAYLIST_SAVE_DIR = "res://addons/AudioCafe/dist/"

func _scan_and_populate_library(current_path: String, audio_manifest_data: Dictionary, audio_type: String) -> bool:
	var dir = DirAccess.open(current_path)
	if not dir:
		printerr("GenerateAudioManifest: Failed to open directory: %s" % current_path)
		return false
	
	var collected_paths_by_key: Dictionary = {}

	dir.list_dir_begin()
	var file_or_dir_name = dir.get_next()
	while file_or_dir_name != "":
		if dir.current_is_dir():
			if not _scan_and_populate_library(current_path.path_join(file_or_dir_name), audio_manifest_data, audio_type):
				return false
		elif file_or_dir_name.ends_with(".ogg") or file_or_dir_name.ends_with(".wav"):
			_files_scanned += 1
			var resource_path = current_path.path_join(file_or_dir_name)
			emit_signal("progress_updated", _files_scanned, _total_files_to_scan, resource_path)

			var uid = ResourceLoader.get_resource_uid(resource_path)
			if uid != -1:
				var root_path_to_remove = ""
				if audio_type == "sfx":
					for p in audio_config.sfx_paths:
						if resource_path.begins_with(p) and p.length() > root_path_to_remove.length():
							root_path_to_remove = p
				else:
					for p in audio_config.music_paths:
						if resource_path.begins_with(p) and p.length() > root_path_to_remove.length():
							root_path_to_remove = p

				var relative_dir_path = resource_path.replace(root_path_to_remove, "").trim_prefix("/").get_base_dir().trim_suffix("/")
				var final_key = ""

				if not relative_dir_path.is_empty():
					final_key = relative_dir_path.replace("/", "_").to_lower()
				else:
					final_key = file_or_dir_name.get_basename().to_lower()

				if not collected_paths_by_key.has(final_key):
					collected_paths_by_key[final_key] = []
				collected_paths_by_key[final_key].append(resource_path)
		file_or_dir_name = dir.get_next()

	for final_key in collected_paths_by_key.keys():
		var playlist = AudioStreamPlaylist.new()
		for path in collected_paths_by_key[final_key]:
			var stream = load(path)
			if stream:
				playlist.add_stream(stream)
		
		var playlist_save_path = PLAYLIST_SAVE_DIR + final_key + ".tres"
		var playlist_dir = playlist_save_path.get_base_dir()
		if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(playlist_dir)):
			DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(playlist_dir))
		
		var error = ResourceSaver.save(playlist, playlist_save_path)
		if error != OK:
			printerr("Failed to save AudioStreamPlaylist resource for key '%s': %s" % [final_key, error])
			return false
		
		audio_manifest_data[final_key] = playlist_save_path
		print("  - Added %s audio to playlist '%s' saved at: %s" % [audio_type, final_key, playlist_save_path])
	
	return true

func _get_uid_from_import_file(import_file_path: String) -> String:
	var config = ConfigFile.new()
	if config.load(import_file_path) == OK:
		return config.get_value("remap", "uid", "")
	return ""
