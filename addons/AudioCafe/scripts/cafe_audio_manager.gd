@tool
extends Node

signal audio_config_updated(config: AudioConfig)

@warning_ignore("unused_signal")
signal play_sfx_requested(sfx_key: String, bus: String, manager_node: Node, loop: bool, shuffle: bool, fade_time: float)

@warning_ignore("unused_signal")
signal play_music_requested(music_key: String, manager_node: Node, loop: bool, shuffle: bool, fade_time: float)

@warning_ignore("unused_signal")
signal music_track_changed(music_key: String)

@warning_ignore("unused_signal")
signal volume_changed(bus_name: String, linear_volume: float)

@warning_ignore("unused_signal")
signal request_audio_start()

signal zone_event_triggered(zone_name: String, event_type: String, body: Node)

const SFX_BUS_NAME = "SFX"
const MUSIC_BUS_NAME = "Music"

const audio_config : AudioConfig = preload("res://addons/AudioCafe/resources/audio_config.tres")
const audio_manifest: AudioManifest = preload("res://addons/AudioCafe/resources/audio_manifest.tres")

var _sfx_library: Dictionary = {}
var _music_library: Dictionary = {}

var _music_playlist_keys: Array = []
var _current_playlist_key: String = ""

@export var _sfx_player_count = 15
var _sfx_players: Array[AudioStreamPlayer] = []
@onready var _music_player: AudioStreamPlayer = $MusicPlayer
@onready var _music_change_timer: Timer = $MusicChangeTimer


func _ready():
	_music_player.bus = MUSIC_BUS_NAME
	_music_player.finished.connect(_on_music_finished)

	play_sfx_requested.connect(_on_play_sfx_requested)
	play_music_requested.connect(_on_play_music_requested)
	
	request_audio_start.connect(_on_request_audio_start)
	
	_setup_audio_buses()
	_load_audio_from_manifest()

func _setup_audio_buses():
	if AudioServer.get_bus_index(MUSIC_BUS_NAME) == -1:
		AudioServer.add_bus(AudioServer.get_bus_count())
		var music_bus_idx = AudioServer.get_bus_count() - 1 # Get the index of the newly added bus
		AudioServer.set_bus_name(music_bus_idx, MUSIC_BUS_NAME)
		AudioServer.set_bus_send(music_bus_idx, "Master")
		print("CafeAudioManager: Created Music audio bus.")
	
	if AudioServer.get_bus_index(SFX_BUS_NAME) == -1:
		AudioServer.add_bus(AudioServer.get_bus_count())
		var sfx_bus_idx = AudioServer.get_bus_count() - 1 # Get the index of the newly added bus
		AudioServer.set_bus_name(sfx_bus_idx, SFX_BUS_NAME)
		AudioServer.set_bus_send(sfx_bus_idx, "Master")
		print("CafeAudioManager: Created SFX audio bus.")

	# Apply initial volumes from audio_config
	apply_volume_to_bus("Master", audio_config.master_volume)
	apply_volume_to_bus(SFX_BUS_NAME, audio_config.sfx_volume)
	apply_volume_to_bus(MUSIC_BUS_NAME, audio_config.music_volume)

func _load_audio_from_manifest():
	if not audio_manifest:
		printerr("CafeAudioManager: AudioManifest not assigned. Please generate it in the editor.")
		return

	_sfx_library = audio_manifest.sfx_data
	_music_library = audio_manifest.music_data
	_music_playlist_keys = _music_library.keys()
	
	print("CafeAudioManager: Loaded audio from manifest. %d music playlists and %d SFX categories found." % [_music_playlist_keys.size(), _sfx_library.size()])
	print("CafeAudioManager: SFX Library Keys: ", _sfx_library.keys())

	var sfx_player_node = get_node_or_null("SFXPlayer")
	if sfx_player_node:
		for child in sfx_player_node.get_children():
			if child is AudioStreamPlayer:
				child.bus = SFX_BUS_NAME
				child.finished.connect(Callable(self, "_on_sfx_player_finished").bind(child))
				_sfx_players.append(child)
	else:
		print("CafeAudioManager: SFXPlayer Node not found in scene. Creating %d AudioStreamPlayers dynamically." % _sfx_player_count)
		for i in range(_sfx_player_count):
			var sfx_player = AudioStreamPlayer.new()
			sfx_player.name = "SFXPlayer_%d" % i
			sfx_player.bus = SFX_BUS_NAME
			sfx_player.finished.connect(Callable(self, "_on_sfx_player_finished").bind(sfx_player))
			add_child(sfx_player)
			_sfx_players.append(sfx_player)


func _on_play_sfx_requested(sfx_key: String, bus: String = SFX_BUS_NAME, manager_node: Node = self, loop: bool = false, shuffle: bool = false, fade_time: float = 0.3):
	if not _sfx_library.has(sfx_key):
		printerr("CafeAudioManager: SFX key not found in library: '%s'" % sfx_key)
		return

	var sfx_playlist_path = _sfx_library[sfx_key]
	var sfx_playlist = load(sfx_playlist_path)

	sfx_playlist.loop = loop
	sfx_playlist.shuffle = shuffle
	sfx_playlist.fade_time = fade_time
	
	if not sfx_playlist or not sfx_playlist is AudioStreamPlaylist:
		printerr("CafeAudioManager: Failed to load AudioStreamPlaylist from path: '%s' for key '%s'" % [sfx_playlist_path, sfx_key])
		return


	for player in _sfx_players:
		if not player.playing:
			player.stream = sfx_playlist
			player.bus = bus
			player.play()
			return

func _on_play_music_requested(music_key: String, manager_node: Node = self, loop: bool = true, shuffle: bool = true, fade_time: float = 0.0):
	if not _music_library.has(music_key):
		printerr("CafeAudioManager: Music key not found in library: '%s'" % music_key)
		return

	var playlist_path = _music_library[music_key]
	var music_playlist = load(playlist_path)

	if not music_playlist or not music_playlist is AudioStreamPlaylist:
		printerr("CafeAudioManager: Failed to load AudioStreamPlaylist from path: '%s' for key '%s'" % [playlist_path, music_key])
		return

	music_playlist.loop = loop
	music_playlist.shuffle = shuffle
	music_playlist.fade_time = fade_time

	if _music_player.stream == music_playlist and _music_player.playing:
		return

	_music_player.stream = music_playlist
	_music_player.play()
	music_track_changed.emit(music_key)

func stop_music():
	_music_player.stop()


func _select_and_play_random_playlist():
	if _music_playlist_keys.is_empty():
		printerr("CafeAudioManager: No music playlists found to play.")
		return

	_current_playlist_key = _music_playlist_keys.pick_random()
	play_music_requested.emit(_current_playlist_key, self, true, true, 0.0)


func apply_volume_to_bus(bus_name: String, linear_volume: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	if bus_index != -1:
		var db_volume = linear_to_db(linear_volume) if linear_volume > 0 else -80.0
		AudioServer.set_bus_volume_db(bus_index, db_volume)
		volume_changed.emit(bus_name, linear_volume)
	else:
		printerr("CafeAudioManager: Audio bus '%s' not found." % bus_name)


func _on_music_finished():
	_select_and_play_random_playlist()

func _on_music_change_timer_timeout():
	_select_and_play_random_playlist()

func _on_sfx_player_finished(player: AudioStreamPlayer):
	player.stream = null # Clear stream after playing to free up memory and allow reuse

func _on_request_audio_start():
	_select_and_play_random_playlist()
	_music_change_timer.start()

func register_audio_zone(audio_zone_node: Node):
	if audio_zone_node.has_signal("zone_event_triggered"):
		audio_zone_node.zone_event_triggered.connect(Callable(self, "_on_audio_zone_event_triggered"))
	else:
		printerr("CafeAudioManager: Node '%s' does not have 'zone_event_triggered' signal." % audio_zone_node.name)

func _on_audio_zone_event_triggered(zone_name: String, event_type: String, body: Node):
	zone_event_triggered.emit(zone_name, event_type, body)
	print("CafeAudioManager: Zone event triggered: %s - %s by %s" % [zone_name, event_type, body.name])
