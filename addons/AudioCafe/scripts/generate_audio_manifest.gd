@tool
extends EditorScript

signal progress_updated(current: int, total: int)
signal generation_finished(success: bool, message: String)

const MANIFEST_SAVE_PATH = "res://addons/AudioCafe/resources/audio_manifest.tres"

var _total_files_to_scan := 0
var _files_scanned := 0

@export var audio_config: AudioConfig = preload("res://addons/AudioCafe/resources/audio_config.tres")

func _run():
	_files_scanned = 0
	_total_files_to_scan = 0

	# Carrega ou cria o AudioManifest
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
			emit_signal("generation_finished", false, "Falha ao criar AudioManifest.tres.")
			return

	# Limpa os dados antigos
	audio_manifest.music_data.clear()
	audio_manifest.sfx_data.clear()

	print("Generating AudioManifest...")

	var success := true
	var message := ""

	# Coleta SFX
	var sfx_resource_paths_by_key := {}
	for path in audio_config.sfx_paths:
		if not _scan_and_collect_resource_paths(path, sfx_resource_paths_by_key, "sfx"):
			success = false
			message = "Falha ao escanear caminhos SFX."
			break

	# Coleta Música
	var music_resource_paths_by_key := {}
	if success:
		for path in audio_config.music_paths:
			if not _scan_and_collect_resource_paths(path, music_resource_paths_by_key, "music"):
				success = false
				message = "Falha ao escanear caminhos de Música."
				break

	# Salva playlists
	if success:
		if not _save_playlists(sfx_resource_paths_by_key, audio_manifest.sfx_data, "sfx"):
			success = false
			message = "Falha ao salvar playlists SFX."

	if success:
		if not _save_playlists(music_resource_paths_by_key, audio_manifest.music_data, "music"):
			success = false
			message = "Falha ao salvar playlists de Música."

	# Salva o AudioManifest final
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
			# Recursão em subpastas
			if not _scan_and_collect_resource_paths(current_path.path_join(file_or_dir_name), resource_paths_by_key, audio_type):
				return false
		elif file_or_dir_name.ends_with(".ogg") or file_or_dir_name.ends_with(".wav"):
			_total_files_to_scan += 1
			_files_scanned += 1
			emit_signal("progress_updated", _files_scanned, _total_files_to_scan)

			var resource_path = current_path.path_join(file_or_dir_name)

			# Descobre root_path a remover
			var root_path_to_remove = ""
			var paths_to_check = (audio_type == "sfx") ? audio_config.sfx_paths : audio_config.music_paths

			for p in paths_to_check:
				if resource_path.begins_with(p) and p.length() > root_path_to_remove.length():
					root_path_to_remove = p

			# Calcula chave final (ex: "ui_click" ou "battle_theme")
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
	const BASE_DIR = "res://addons/AudioCafe/playlists/"
	var playlists_dir = "%s%s/" % [BASE_DIR, audio_type]
	DirAccess.make_dir_recursive(playlists_dir)

	var success := true

	for final_key in resource_paths_by_key.keys():
		var stream_paths: Array = resource_paths_by_key[final_key]
		var playlist := AudioStreamPlaylist.new()

		for path in stream_paths:
			var stream: AudioStream = ResourceLoader.load(path, "AudioStream")
			if stream:
				playlist.add_stream(stream)
			else:
				printerr("Failed to load AudioStream from path: %s" % path)
				success = false

		if playlist.get_stream_count() == 0:
			continue # evita salvar playlist vazia

		var save_path := "%s%s_playlist.tres" % [playlists_dir, final_key]
		var error = ResourceSaver.save(playlist, save_path)

		if error != OK:
			printerr("Failed to save %s playlist %s: %s" % [audio_type, final_key, error])
			success = false
		else:
			print("Saved %s playlist to: %s" % [audio_type, save_path])
			# Salva apenas o caminho no manifest
			library_to_populate[final_key] = save_path

	return success
