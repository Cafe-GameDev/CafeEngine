@tool
extends EditorScript
class_name GenerateAlbuns

signal progress_updated(current: int, total: int)
signal generation_finished(success: bool, message: String)

const MANIFEST_SAVE_FILE = "res://addons/audiocafe/resources/audio_manifest.tres"

var _total_files_to_scan = 0
var _files_scanned = 0

@export var audio_config: AudioConfig = preload("res://addons/audiocafe/resources/audio_config.tres")

func _run():
	_total_files_to_scan = 0
	_files_scanned = 0

	for path in audio_config.assets_paths:
		_count_files_in_directory(path)

	var collected_streams: Dictionary = {}

	var success_collection = _collect_streams_by_key(audio_config.assets_paths, collected_streams)

	var audio_manifest = AudioManifest.new()
	var overall_success = true
	var message = ""

	var albuns_dist_save_path = audio_config.get_albuns_save_path()
	var randomizer_dist_save_path = audio_config.get_randomized_save_path()
	var interactive_dist_save_path = audio_config.get_interactive_save_path()
	var synchronized_dist_save_path = audio_config.get_synchronized_save_path()

	var dist_dir_access = DirAccess.open("res://")
	if not dist_dir_access:
		printerr("Failed to open directory 'res://'.")
		emit_signal("generation_finished", false, "Failed to access the project's base directory.")
		return

	for path_to_create in [albuns_dist_save_path, randomizer_dist_save_path, interactive_dist_save_path, synchronized_dist_save_path]:
		var relative_path = path_to_create.replace("res://", "")
		if not dist_dir_access.dir_exists(relative_path):
			var error = dist_dir_access.make_dir_recursive(relative_path)
			if error != OK:
				printerr("Failed to create directory: %s, Error: %s" % [path_to_create, error])
				overall_success = false
				message = "Failed to create distribution directories."
				break
			else:
				pass
	
	if not overall_success:
		emit_signal("generation_finished", overall_success, message)
		return

	if audio_config.gen_playlist:
		var result = generate_playlist(audio_manifest, collected_streams, albuns_dist_save_path, overall_success, message)
		overall_success = result[0]
		message += result[1]
		
	if audio_config.gen_randomizer:
		var result = generate_randomizer(audio_manifest, collected_streams, randomizer_dist_save_path)
		overall_success = result[0]
		message += result[1]
		
	if audio_config.gen_synchronized:
		var result = generate_synchronized(audio_manifest, collected_streams, synchronized_dist_save_path)
		overall_success = result[0]
		message += result[1]

	var collected_interactive_streams: Dictionary = {}
	if not _scan_directory_for_resources(interactive_dist_save_path, "AudioStreamInteractive", collected_interactive_streams):
		overall_success = false
		message = "Failed to collect AudioStreamInteractive."
	else:
		audio_manifest.interactive = collected_interactive_streams

	if overall_success:
		_update_manifest_with_uids(audio_manifest) # Call this before saving
		var err = ResourceSaver.save(audio_manifest, MANIFEST_SAVE_FILE)
		if err != OK:
			overall_success = false
			message = "Failed to save AudioManifest.tres: %s" % err
		else:
			pass

	emit_signal("generation_finished", overall_success, message)

func _update_manifest_with_uids(audio_manifest: AudioManifest):
	_add_uids_to_category(audio_manifest.playlists)
	_add_uids_to_category(audio_manifest.randomizer)
	_add_uids_to_category(audio_manifest.synchronized)

func _add_uids_to_category(category_dict: Dictionary):
	for key in category_dict.keys():
		var entry = category_dict[key]
		if entry.size() >= 2: # Ensure it has at least path and count
			var resource_path = entry[0]
			var uid = ResourceLoader.get_resource_uid(resource_path)
			if uid != -1:
				# Convert the entry to a WritableArray to modify it
				var new_entry = Array(entry)
				if new_entry.size() < 3:
					new_entry.append("uid://%s" % str(uid))
				else:
					new_entry[2] = "uid://%s" % str(uid)
				category_dict[key] = new_entry
			else:
				printerr("Failed to get UID for resource: %s" % resource_path)

func generate_playlist(audio_manifest: AudioManifest, collected_streams: Dictionary, albuns_dist_save_path: String, overall_success: bool, message: String) -> Array:
	for final_key in collected_streams.keys():
		var streams_for_key = collected_streams[final_key]
		var albuns_file_path = "%s%s_playlist.tres" % [albuns_dist_save_path, final_key]
		
		var playlist: AudioStreamPlaylist
		if FileAccess.file_exists(albuns_file_path):
			playlist = load(albuns_file_path)
			if playlist == null:
				playlist = AudioStreamPlaylist.new()
		else:
			playlist = AudioStreamPlaylist.new()

		for i in range(playlist.stream_count):
			playlist.set("stream_%d" % i, null)
		playlist.stream_count = 0

		for stream in streams_for_key:
			var current_index = playlist.stream_count
			playlist.set("stream_%d" % current_index, stream)
			playlist.stream_count = current_index + 1
		
		var err = ResourceSaver.save(playlist, albuns_file_path)
		if err != OK:
			printerr("Failed to save playlist %s: %s" % [albuns_file_path, err])
			overall_success = false
			message = "Failed to save playlists."
			break
		
		audio_manifest.playlists[final_key] = [albuns_file_path, str(playlist.stream_count)]

	return [overall_success, message]

func generate_randomizer(audio_manifest: AudioManifest, collected_streams: Dictionary, randomizer_dist_save_path: String) -> Array:
	for final_key in collected_streams.keys():
		var streams_for_key = collected_streams[final_key]
		if streams_for_key.size() == 0:
			continue

		var randomizer_file_path = "%s%s_randomizer.tres" % [randomizer_dist_save_path, final_key]

		var randomizer: AudioStreamRandomizer
		if FileAccess.file_exists(randomizer_file_path):
			randomizer = load(randomizer_file_path)
			if randomizer == null:
				randomizer = AudioStreamRandomizer.new()
		else:
			randomizer = AudioStreamRandomizer.new()

		# Explicitly remove all existing streams
		for i in range(randomizer.streams_count - 1, -1, -1):
			randomizer.remove_stream(i)
		randomizer.streams_count = 0

		var idx := 0
		for s in streams_for_key:
			if s == null:
				continue
			randomizer.add_stream(-1, s, 1.0)
			idx += 1

		randomizer.streams_count = idx

		var err = ResourceSaver.save(randomizer, randomizer_file_path)
		if err != OK:
			printerr("Failed to save Randomizer %s: %s" % [randomizer_file_path, err])
			return [false, "[Randomizer:%s] Failed to save: %s" % [final_key, str(err)]]

		audio_manifest.randomizer[final_key] = [
			randomizer_file_path,
			str(randomizer.streams_count)
		]

	return [true, ""]

func generate_synchronized(audio_manifest: AudioManifest, collected_streams: Dictionary, synchronized_dist_save_path: String) -> Array:
	const MAX_SYNCHRONIZED_STREAMS = 32

	for final_key in collected_streams.keys():
		var streams_for_key = collected_streams[final_key]
		if streams_for_key.size() == 0:
			continue

		var synchronized_file_path = "%s%s_synchronized.tres" % [synchronized_dist_save_path, final_key]

		var sync: AudioStreamSynchronized
		if FileAccess.file_exists(synchronized_file_path):
			sync = load(synchronized_file_path)
			if sync == null:
				sync = AudioStreamSynchronized.new()
		else:
			sync = AudioStreamSynchronized.new()

		for i in range(sync.stream_count):
			sync.set("stream_%d" % i, null)
		sync.stream_count = 0

		var idx := 0
		for s in streams_for_key:
			if s == null:
				continue
			if idx >= MAX_SYNCHRONIZED_STREAMS:
				break
			sync.set("stream_%d/stream" % idx, s)
			sync.set("stream_%d/volume" % idx, 0.0)
			idx += 1

		sync.stream_count = idx

		var err = ResourceSaver.save(sync, synchronized_file_path)
		if err != OK:
			printerr("Failed to save Synchronized %s: %s" % [synchronized_file_path, err])
			return [false, "[Synchronized:%s] Failed to save: %s" % [final_key, str(err)]]

		audio_manifest.synchronized[final_key] = [
			synchronized_file_path,
			str(sync.stream_count)
		]

	return [true, ""]

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

func _collect_streams_by_key(paths: Array[String], collected_streams: Dictionary) -> bool:
	for path in paths:
		if not _scan_directory_for_streams(path, collected_streams, path):
			return false
	return true

func _scan_directory_for_streams(current_path: String, collected_streams: Dictionary, root_path: String) -> bool:
	var dir = DirAccess.open(current_path)
	if not dir:
		printerr("GenerateAudioManifest: Failed to open directory: %s" % current_path)
		return false
	
	dir.list_dir_begin()
	var file_or_dir_name = dir.get_next()
	while file_or_dir_name != "":
		if dir.current_is_dir():
			if not _scan_directory_for_streams(current_path.path_join(file_or_dir_name), collected_streams, root_path):
				return false
		elif file_or_dir_name.ends_with(".ogg") or file_or_dir_name.ends_with(".wav"):
			_files_scanned += 1
			emit_signal("progress_updated", _files_scanned, _total_files_to_scan)

			var resource_path = current_path.path_join(file_or_dir_name)
			var audio_stream = load(resource_path)
			if audio_stream == null:
				printerr("Failed to load AudioStream: %s" % resource_path)
				file_or_dir_name = dir.get_next()
				continue

			var relative_dir_path = resource_path.replace(root_path, "").trim_prefix("/").get_base_dir().trim_suffix("/")
			var final_key = ""
			if not relative_dir_path.is_empty():
				final_key = relative_dir_path.replace("/", "_").to_lower()
			else:
				final_key = file_or_dir_name.get_basename().to_lower()

			if not collected_streams.has(final_key):
				collected_streams[final_key] = []
			collected_streams[final_key].append(audio_stream)
			
		file_or_dir_name = dir.get_next()

	return true

func _scan_directory_for_resources(current_path: String, resource_class_name: String, collected_resources: Dictionary) -> bool:
	var dir = DirAccess.open(current_path)
	if not dir:
		printerr("GenerateAudioManifest: Failed to open directory: %s" % current_path)
		return false
	
	dir.list_dir_begin()
	var file_or_dir_name = dir.get_next()
	while file_or_dir_name != "":
		if dir.current_is_dir():
			if not _scan_directory_for_resources(current_path.path_join(file_or_dir_name), resource_class_name, collected_resources):
				return false
		elif file_or_dir_name.ends_with(".tres"):
			var resource_path = current_path.path_join(file_or_dir_name)
			var loaded_resource = load(resource_path)
			if loaded_resource and loaded_resource.get_class() == resource_class_name:
				var final_key = file_or_dir_name.get_basename().to_lower()
				collected_resources[final_key] = resource_path
			
		file_or_dir_name = dir.get_next()

	return true
