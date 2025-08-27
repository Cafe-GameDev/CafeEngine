@tool
extends Node

# CafeAudioManager.gd
#
# This script defines the CafeAudioManager, a robust and decoupled audio management
# system for Godot Engine projects. It acts as a dedicated EventBus for all
# audio-related communications, centralizing audio logic and making it easier
# to manage throughout your game.
#
# Key Features:
# - Dynamic Audio Loading: Automatically scans and loads audio files from
#   configurable directories, categorizing them into SFX and music libraries.
# - SFX Player Pooling: Utilizes a configurable pool of AudioStreamPlayer instances
#   to handle sound effects, preventing audio cutting and optimizing performance.
# - Music Playlist Management: Provides comprehensive management for music,
#   including defining playlists, random track playback, and transitions.
# - Decoupled Volume Control: Offers a clean way to control the volume of
#   different audio buses (Master, Music, SFX) without direct dependencies.
# - Export Compatibility: Ensures audio setup works seamlessly in exported builds
#   using an AudioManifest to reference audio resources via their unique IDs (UIDs).
#
# Limitations:
# - Mono Audio Only: This AudioManager is exclusively designed for mono audio,
#   without support for 2D or 3D positional audio effects.


# Emitted when a request to play a sound effect is received.
# @param sfx_key: The key of the SFX to be played (as defined in AudioManifest).
# @param bus: The name of the audio bus to play the SFX on (e.g., "SFX", "UI").
# @param manager_node: (Optional, for v2.0) A CafeAudioPlayer2D/3D node for positional playback.
@warning_ignore("unused_signal")
signal play_sfx_requested(sfx_key: String, bus: String, manager_node: Node)

# Emitted when a request to play a music track or playlist is received.
# @param music_key: The key of the music track/playlist to be played (as defined in AudioManifest).
# @param manager_node: (Optional, for v2.0) A CafeAudioPlayer2D/3D node for positional playback.
@warning_ignore("unused_signal")
signal play_music_requested(music_key: String, manager_node: Node)

# Emitted when a new music track starts playing.
# @param music_key: The string key of the music track that just started.
@warning_ignore("unused_signal")
signal music_track_changed(music_key: String)

# Emitted when the volume of an audio bus is changed.
# This signal is also listened to by the AudioManager itself to apply volume changes.
# @param bus_name: The name of the audio bus whose volume changed (e.g., "Master", "Music", "SFX").
# @param linear_volume: The new linear volume value (0.0 to 1.0).
@warning_ignore("unused_signal")
signal volume_changed(bus_name: String, linear_volume: float)

# Emitted to request the AudioManager to start its audio setup and playback.
# This is typically used by a GlobalEvents singleton or similar to initialize audio.
@warning_ignore("unused_signal")
signal request_audio_start()

# Constants for audio bus names.
const SFX_BUS_NAME = "SFX"
const MUSIC_BUS_NAME = "Music"

# The AudioManifest resource containing all audio data (SFX and music keys mapped to UIDs).
@export var audio_manifest: AudioManifest

# Internal dictionaries to store loaded SFX and music data from the AudioManifest.
var _sfx_library: Dictionary = {}
var _music_library: Dictionary = {}

# List of available music playlist keys for random selection.
var _music_playlist_keys: Array = []
# The key of the currently playing music playlist.
var _current_playlist_key: String = ""

# The number of AudioStreamPlayer instances to create for SFX pooling.
@export var _sfx_player_count = 15
# Pool of AudioStreamPlayer nodes used for playing SFX.
var _sfx_players: Array[AudioStreamPlayer] = []
# The AudioStreamPlayer node dedicated to playing music.
@onready var _music_player: AudioStreamPlayer = $MusicPlayer
# Timer used to trigger automatic music track changes (e.g., for playlists).
@onready var _music_change_timer: Timer = $MusicChangeTimer


func _ready():
	# Configure the music player and connect its finished signal.
	_music_player.bus = MUSIC_BUS_NAME
	_music_player.finished.connect(_on_music_finished)

	# Connect to the AudioManager's own signals to handle playback requests.
	play_sfx_requested.connect(_on_play_sfx_requested)
	play_music_requested.connect(_on_play_music_requested)
	
	# Connect to the request_audio_start signal to initialize audio when triggered.
	request_audio_start.connect(_on_request_audio_start)

# Initializes the audio manager by setting up buses, loading the manifest,
# and starting initial music playback. This function is called when the
# 'request_audio_start' signal is emitted.
func _on_request_audio_start():
	_setup_audio_buses()
	_load_audio_from_manifest()
	_select_and_play_random_playlist()
	_music_change_timer.start()

# Ensures that the "Music" and "SFX" audio buses exist in the AudioServer.
# If a bus does not exist, it is created and configured to send to the "Master" bus.
func _setup_audio_buses():
	# Ensure Music bus exists and is configured.
	if AudioServer.get_bus_index(MUSIC_BUS_NAME) == -1:
		AudioServer.add_bus(AudioServer.get_bus_count())
		var music_bus_idx = AudioServer.get_bus_count() - 1 # Get the index of the newly added bus
		AudioServer.set_bus_name(music_bus_idx, MUSIC_BUS_NAME)
		AudioServer.set_bus_send(music_bus_idx, "Master")
		print("CafeAudioManager: Created Music audio bus.")
	
	# Ensure SFX bus exists and is configured.
	if AudioServer.get_bus_index(SFX_BUS_NAME) == -1:
		AudioServer.add_bus(AudioServer.get_bus_count())
		var sfx_bus_idx = AudioServer.get_bus_count() - 1 # Get the index of the newly added bus
		AudioServer.set_bus_name(sfx_bus_idx, SFX_BUS_NAME)
		AudioServer.set_bus_send(sfx_bus_idx, "Master")
		print("CafeAudioManager: Created SFX audio bus.")

# Loads audio data (SFX and music) from the assigned AudioManifest resource.
# It populates the internal libraries and initializes the SFX player pool,
# either by collecting existing AudioStreamPlayer nodes or creating them dynamically.
func _load_audio_from_manifest():
	if not audio_manifest:
		printerr("CafeAudioManager: AudioManifest not assigned. Please generate it in the editor.")
		return

	_sfx_library = audio_manifest.sfx_data
	_music_library = audio_manifest.music_data
	_music_playlist_keys = _music_library.keys()
	
	print("CafeAudioManager: Loaded audio from manifest. %d music playlists and %d SFX categories found." % [_music_playlist_keys.size(), _sfx_library.size()])

	# Collect SFX players from the scene if an "SFXPlayer" node exists,
	# otherwise create a pool of AudioStreamPlayer nodes dynamically.
	var sfx_player_node = get_node_or_null("SFXPlayer")
	if sfx_player_node:
		for child in sfx_player_node.get_children():
			if child is AudioStreamPlayer:
				child.bus = SFX_BUS_NAME
				child.finished.connect(Callable(self, "_on_sfx_player_finished").bind(child))
				_sfx_players.append(child)
	else:
		# If no dedicated SFXPlayer node is found, create AudioStreamPlayers dynamically
		# to form the SFX player pool.
		print("CafeAudioManager: SFXPlayer Node not found in scene. Creating %d AudioStreamPlayers dynamically." % _sfx_player_count)
		for i in range(_sfx_player_count):
			var sfx_player = AudioStreamPlayer.new()
			sfx_player.name = "SFXPlayer_%d" % i
			sfx_player.bus = SFX_BUS_NAME
			sfx_player.finished.connect(Callable(self, "_on_sfx_player_finished").bind(sfx_player))
			add_child(sfx_player)
			_sfx_players.append(sfx_player)

# --- Public Playback Functions (via signals) ---

# Handles the 'play_sfx_requested' signal.
# Finds an available SFX player from the pool, loads the requested SFX
# (resolved via AudioManifest UID), and plays it on the specified bus.
# @param sfx_key: The key of the SFX to be played.
# @param bus: The audio bus to play the SFX on.
# @param manager_node: (Optional) A node for positional audio (currently unused in mono setup).
func _on_play_sfx_requested(sfx_key: String, bus: String = SFX_BUS_NAME, manager_node: Node = self):
	if not _sfx_library.has(sfx_key):
		printerr("CafeAudioManager: SFX key not found in library: '%s'" % sfx_key)
		return

	var sfx_uids = _sfx_library[sfx_key]
	if sfx_uids.is_empty():
		printerr("CafeAudioManager: SFX category '%s' is empty." % sfx_key)
		return
	
	# Select a random UID from the SFX category and resolve its resource path.
	var random_uid_str = sfx_uids.pick_random()
	var uid_int = random_uid_str.replace("uid://", "").to_int()
	var resource_path = ResourceUID.get_id_path(uid_int)

	if resource_path.is_empty():
		printerr("CafeAudioManager: Failed to get resource path for SFX UID: '%s'" % random_uid_str)
		return

	# Load the audio stream.
	var sound_stream = load(resource_path)

	if sound_stream == null:
		printerr("CafeAudioManager: Failed to load SFX stream from path: '%s' (UID: '%s')" % [resource_path, random_uid_str])
		return

	# Find an available SFX player in the pool and play the sound.
	for player in _sfx_players:
		if not player.playing:
			player.stream = sound_stream
			player.bus = bus
			player.play()
			return

# Handles the 'play_music_requested' signal.
# Loads the requested music track (resolved via AudioManifest UID) and plays it.
# If the same music is already playing, it does nothing.
# Emits 'music_track_changed' when a new track starts.
# @param music_key: The key of the music track or playlist to be played.
# @param manager_node: (Optional) A node for positional audio (currently unused in mono setup).
func _on_play_music_requested(music_key: String, manager_node: Node = self):
	if not _music_library.has(music_key):
		printerr("CafeAudioManager: Music key not found in library: '%s'" % music_key)
		return

	var music_uids = _music_library[music_key]
	if music_uids.is_empty():
		printerr("CafeAudioManager: Music category '%s' is empty." % music_key)
		return

	# Select a random UID from the music category and resolve its resource path.
	var random_uid_str = music_uids.pick_random()
	var uid_int = random_uid_str.replace("uid://", "").to_int()
	var resource_path = ResourceUID.get_id_path(uid_int)

	if resource_path.is_empty():
		printerr("CafeAudioManager: Failed to get resource path for UID: '%s'" % random_uid_str)
		return

	# Load the audio stream.
	var music_stream = load(resource_path)

	if music_stream == null:
		printerr("CafeAudioManager: Failed to load music stream from path: '%s' (UID: '%s')" % [resource_path, random_uid_str])
		return

	# If the requested music is already playing, do nothing.
	if _music_player.stream == music_stream and _music_player.playing:
		return

	_music_player.stream = music_stream
	_music_player.play()
	music_track_changed.emit(music_key)

func stop_music():
	_music_player.stop()

# --- Playlist Logic ---

# Selects a random music playlist from the loaded keys and requests its playback.
func _select_and_play_random_playlist():
	if _music_playlist_keys.is_empty():
		printerr("CafeAudioManager: No music playlists found to play.")
		return

	_current_playlist_key = _music_playlist_keys.pick_random()
	play_music_requested.emit(_current_playlist_key)

# --- Volume Control ---

# Applies a given linear volume to a specified audio bus.
# Converts linear volume (0.0-1.0) to decibels and updates the AudioServer.
# Emits 'volume_changed' signal after applying the change.
# @param bus_name: The name of the audio bus to modify.
# @param linear_volume: The desired linear volume (0.0 to 1.0).
func apply_volume_to_bus(bus_name: String, linear_volume: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	if bus_index != -1:
		var db_volume = linear_to_db(linear_volume) if linear_volume > 0 else -80.0
		AudioServer.set_bus_volume_db(bus_index, db_volume)
		volume_changed.emit(bus_name, linear_volume)
	else:
		printerr("CafeAudioManager: Audio bus '%s' not found." % bus_name)

# --- Signal Handlers ---

# Called when the music player finishes playing a track.
# Triggers the selection and playback of a new random playlist track.
func _on_music_finished():
	_select_and_play_random_playlist()

# Called when the music change timer times out.
# Triggers the selection and playback of a new random playlist track.
func _on_music_change_timer_timeout():
	_select_and_play_random_playlist()

# Called when an SFX player finishes playing a sound.
# Clears the player's stream to free up memory and make it available for reuse in the pool.
# @param player: The AudioStreamPlayer that finished playing.
func _on_sfx_player_finished(player: AudioStreamPlayer):
	player.stream = null # Clear stream after playing to free up memory and allow reuse
