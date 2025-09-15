@tool
extends EditorScript
class_name GenerateAudioManifest

signal progress_updated(current: int, total: int)
signal generation_finished(success: bool, message: String)

const MANIFEST_SAVE_FILE = "res://addons/AudioCafe/resources/audio_manifest.tres"
const DIST_SAVE_PATH = "res://addons/AudioCafe/dist/"

var _total_files_to_scan = 0
var _files_scanned = 0

@export var audio_config: AudioConfig = preload("res://addons/AudioCafe/resources/audio_config.tres")

func _run():
	_total_files_to_scan = 0
	_files_scanned = 0

	for path in audio_config.sfx_paths:
		_count_files_in_directory(path)
	for path in audio_config.music_paths:
		_count_files_in_directory(path)

	var audio_manifest = AudioManifest.new()
	var success = true
	var message = ""

	for path in audio_config.sfx_paths:
		if not _scan_and_create_playlist(path, audio_manifest.sfx_data, "sfx"):
			success = false
			message = "Falha ao escanear caminhos SFX."
			break
		if not success:
			break

	for path in audio_config.music_paths:
		if not _scan_and_create_playlist(path, audio_manifest.music_data, "music"):
			success = false
			message = "Falha ao escanear caminhos de Música."
			break
		if not success:
			break
	
	if success:
		var error = ResourceSaver.save(audio_manifest, MANIFEST_SAVE_FILE)
		if error != OK:
			success = false
			message = "Falha ao salvar AudioManifest.tres: %s" % error

	emit_signal("generation_finished", success, message)


func _count_files_in_directory(current_path: String):
	var dir = DirAccess.open(current_path)
	if not dir:
		return

	dir.list_dir_begin()
	var file_or_dir_name = dir.get_next()
	while file_or_dir_name != "":
		if dir.current_is_dir():
			_count_files_in_directory(current_path.path_join(file_or_dir_name))
		elif file_or_dir_name.ends_with(".ogg") or file_or_dir_name.ends_with(".wav"):
			_total_files_to_scan += 1
		file_or_dir_name = dir.get_next()


func _scan_and_create_playlist(current_path: String, library: Dictionary, audio_type: String) -> bool:
	var dir = DirAccess.open(current_path)
	if not dir:
		printerr("GenerateAudioManifest: Failed to open directory: %s" % current_path)
		return false
	
	dir.list_dir_begin()
	var file_or_dir_name = dir.get_next()
	while file_or_dir_name != "":
		if dir.current_is_dir():
			if not _scan_and_create_playlist(current_path.path_join(file_or_dir_name), library, audio_type):
				return false
		elif file_or_dir_name.ends_with(".ogg") or file_or_dir_name.ends_with(".wav"):
			_files_scanned += 1
			emit_signal("progress_updated", _files_scanned, _total_files_to_scan)

			var resource_path = current_path.path_join(file_or_dir_name)
			var audio_stream = load(resource_path)
			if audio_stream == null:
				printerr("Falha ao carregar AudioStream: %s" % resource_path)
				file_or_dir_name = dir.get_next()
				continue

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

			var playlist_file_path = "%s%s_playlist.tres" % [DIST_SAVE_PATH, final_key]

			var playlist: AudioStreamPlaylist
			if FileAccess.file_exists(playlist_file_path):
				playlist = load(playlist_file_path)
				if playlist == null:
					playlist = AudioStreamPlaylist.new()
			else:
				playlist = AudioStreamPlaylist.new()

			var current_index = playlist.stream_count
			playlist.set("stream_%d" % current_index, audio_stream)
			playlist.stream_count = current_index + 1

			var err = ResourceSaver.save(playlist, playlist_file_path)
			if err != OK:
				printerr("Falha ao salvar playlist %s: %s" % [playlist_file_path, err])

			library[final_key] = playlist_file_path
			
		file_or_dir_name = dir.get_next()

	return true
