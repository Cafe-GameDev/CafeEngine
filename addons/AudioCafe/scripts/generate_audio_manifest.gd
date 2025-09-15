@tool
extends EditorScript
signal progress_updated(current: int, total: int)
signal generation_finished(success: bool, message: String)

const MANIFEST_SAVE_PATH = "res://addons/AudioCafe/resources/audio_manifest.tres"

var _total_files_to_scan = 0
var _files_scanned = 0

@export var audio_config: AudioConfig = preload("res://addons/AudioCafe/resources/audio_config.tres")

func _run():
	_files_scanned = 0
	_total_files_to_scan = 0 # Será preenchido durante a varredura

	var audio_manifest: AudioManifest = ResourceLoader.load(MANIFEST_SAVE_PATH)
	if not audio_manifest or not audio_manifest is AudioManifest:
		print("AudioManifest.tres not found or is invalid. Creating a new one.")
		audio_manifest = AudioManifest.new()
		var dir_path = MANIFEST_SAVE_PATH.get_base_dir()
		if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(dir_path)):
			DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(dir_path))
		var save_error = ResourceSaver.save(audio_manifest, MANIFEST_SAVE_PATH)
		if save_error != OK:
			printerr("Failed to create new AudioManifest.tres: %s" % save_error)
			emit_signal("generation_finished", false, "Failed to create new AudioManifest.tres.")
			return

	audio_manifest.music_data.clear()
	audio_manifest.sfx_data.clear()

	print("Generating AudioManifest...")
	
	var success = true
	var message = ""

	var sfx_resource_paths_by_key = {}
	for path in audio_config.sfx_paths:
		if not _scan_and_collect_resource_paths(path, sfx_resource_paths_by_key, "sfx"):
			success = false
			message = "Falha ao escanear caminhos SFX."
			break
		if not success:
			break

	var music_resource_paths_by_key = {}
	for path in audio_config.music_paths:
		if not _scan_and_collect_resource_paths(path, music_resource_paths_by_key, "music"):
			success = false
			message = "Falha ao escanear caminhos de Música."
			break
		if not success:
			break
	
	if success:
		if not _save_playlists(sfx_resource_paths_by_key, audio_manifest.sfx_data, "sfx"):
			success = false
			message = "Falha ao salvar playlists SFX."
		
		if success and not _save_playlists(music_resource_paths_by_key, audio_manifest.music_data, "music"):
			success = false
			message = "Falha ao salvar playlists de Música."

	if success:
		var error = ResourceSaver.save(audio_manifest, MANIFEST_SAVE_PATH)
		if error != OK:
			success = false
			message = "Falha ao salvar AudioManifest.tres: %s" % error
		else:
			print("AudioManifest generated and saved to: %s" % MANIFEST_SAVE_PATH)

	emit_signal("generation_finished", success, message)

func _scan_and_collect_resource_paths(current_path: String, resource_paths_by_key: Dictionary, audio_type: String) -> bool:
	var dir = DirAccess.open(current_path)
	if not dir:
		printerr("GenerateAudioManifest: Failed to open directory: %s" % current_path)
		return false
	
	dir.list_dir_begin()
	var file_or_dir_name = dir.get_next()
	while file_or_dir_name != "":
		if dir.current_is_dir():
			if not _scan_and_collect_resource_paths(current_path.path_join(file_or_dir_name), resource_paths_by_key, audio_type):
				return false
		elif file_or_dir_name.ends_with(".ogg") or file_or_dir_name.ends_with(".wav"):
			_total_files_to_scan += 1 # Incrementa o total de arquivos durante a varredura
			_files_scanned += 1
			emit_signal("progress_updated", _files_scanned, _total_files_to_scan)

			var resource_path = current_path.path_join(file_or_dir_name)
			
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

			if not resource_paths_by_key.has(final_key):
				resource_paths_by_key[final_key] = []
			resource_paths_by_key[final_key].append(resource_path)
			print("  - Collected %s audio resource path: %s for key '%s'" % [audio_type, resource_path, final_key])
		file_or_dir_name = dir.get_next()
	return true

func _save_playlists(resource_paths_by_key: Dictionary, library_to_populate: Dictionary, audio_type: String) -> bool:
	const PLAYLISTS_DIR = "res://addons/AudioCafe/playlists/"
	var success = true

	DirAccess.make_dir_recursive(PLAYLISTS_DIR) # Garante que o diretório exista

	for final_key in resource_paths_by_key.keys():
		var stream_paths = resource_paths_by_key[final_key]
		var playlist := AudioStreamPlaylist.new()
		
		for path in stream_paths:
			var stream: AudioStream = load(path)
			if stream:
				playlist.add_stream(stream)
			else:
				printerr("Failed to load AudioStream from path: %s" % path)
				success = false
		
		var save_path := "%s%s_playlist.tres" % [PLAYLISTS_DIR, final_key]
		var error = ResourceSaver.save(playlist, save_path)
		if error != OK:
			printerr("Failed to save %s playlist %s: %s" % [audio_type, final_key, error])
			success = false
		else:
			print("Saved %s playlist to: %s" % [audio_type, save_path])
			library_to_populate[final_key] = load(save_path) # Armazena a referência ao recurso salvo
	return success



