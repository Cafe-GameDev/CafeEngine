@tool
extends Node

@warning_ignore("unused_signal")
signal play_sfx_requested(sfx_key: String, bus: String, manager_node: Node)

@warning_ignore("unused_signal")
signal play_music_requested(music_key: String)

@warning_ignore("unused_signal")
signal music_track_changed(music_key: String)

@warning_ignore("unused_signal")
signal volume_changed(bus_name: String, linear_volume: float)

@warning_ignore("unused_signal")
signal request_audio_start()

# Sinal emitido quando as configurações de áudio são atualizadas via audio_config.tres
signal audio_config_updated(config: AudioConfig)

const SFX_BUS_NAME = "SFX"
const MUSIC_BUS_NAME = "Music"

# Referência ao recurso de configuração de áudio
var audio_config: AudioConfig

@export var audio_manifest: AudioManifest = preload("res://addons/AudioCafe/resources/audio_manifest.tres")

var _sfx_library: Dictionary = {}
var _music_library: Dictionary = {}

var _music_playlist_keys: Array = []
var _current_playlist_key: String = ""
var _current_playlist_track_index: int = 0

@export var _sfx_player_count = 15
var _sfx_players: Array[AudioStreamPlayer] = []
@onready var _music_player: AudioStreamPlayer = $MusicPlayer
@onready var _music_change_timer: Timer = $MusicChangeTimer


func _ready():
	_music_player.bus = MUSIC_BUS_NAME
	_music_player.finished.connect(_on_music_finished)

	play_sfx_requested.connect(Callable(self, "play_sfx_by_key"))
	play_music_requested.connect(Callable(self, "play_music_by_key"))
	
	request_audio_start.connect(_on_request_audio_start)
	
	_setup_audio_buses()
	_load_audio_from_manifest()

	# Carrega o audio_config.tres e conecta ao seu sinal de mudança
	audio_config = load("res://addons/AudioCafe/resources/audio_config.tres")
	if audio_config:
		audio_config.connect("config_changed", Callable(self, "_on_audio_config_changed"))
		_apply_initial_config()
	else:
		push_error("CafeAudioManager: audio_config.tres não encontrado!")

func _apply_initial_config():
	# Aplica as configurações iniciais do AudioConfig
	_on_audio_config_changed() # Chama o método de atualização para carregar os valores iniciais

func _on_audio_config_changed():
	# Este método é chamado quando o audio_config.tres é alterado e salvo.
	# Ele emite o sinal unificado com a instância atual do AudioConfig.
	if audio_config:
		emit_signal("audio_config_updated", audio_config)

		# Aplica as configurações de volume aos buses de áudio
		apply_volume_to_bus("Master", audio_config.master_volume)
		apply_volume_to_bus(SFX_BUS_NAME, audio_config.sfx_volume)
		apply_volume_to_bus(MUSIC_BUS_NAME, audio_config.music_volume)
	else:
		push_error("CafeAudioManager: AudioConfig é nulo ao tentar aplicar mudanças.")

func _on_request_audio_start():
	_setup_audio_buses()
	_load_audio_from_manifest()
	# Inicia a reprodução de uma playlist padrão ou aleatória
	if not audio_config.music_playlists.is_empty():
		var default_playlist_key = audio_config.music_playlists.keys().pick_random()
		play_playlist(default_playlist_key)
	_music_change_timer.start()

func _setup_audio_buses():
	if AudioServer.get_bus_index(MUSIC_BUS_NAME) == -1:
		AudioServer.add_bus(AudioServer.get_bus_count())
		var music_bus_idx = AudioServer.get_bus_count() - 1
		AudioServer.set_bus_name(music_bus_idx, MUSIC_BUS_NAME)
		AudioServer.set_bus_send(music_bus_idx, "Master")
		print("CafeAudioManager: Created Music audio bus.")
	
	if AudioServer.get_bus_index(SFX_BUS_NAME) == -1:
		AudioServer.add_bus(AudioServer.get_bus_count())
		var sfx_bus_idx = AudioServer.get_bus_count() - 1
		AudioServer.set_bus_name(sfx_bus_idx, SFX_BUS_NAME)
		AudioServer.set_bus_send(sfx_bus_idx, "Master")
		print("CafeAudioManager: Created SFX audio bus.")

func _load_audio_from_manifest():
	if not audio_manifest:
		printerr("CafeAudioManager: AudioManifest not assigned. Please generate it in the editor.")
		return

	_sfx_library = audio_manifest.sfx_data
	_music_library = audio_manifest.music_data
	_music_playlist_keys = _music_library.keys()
	
	print("CafeAudioManager: Loaded audio from manifest. %d music playlists and %d SFX categories found." % [_music_playlist_keys.size(), _sfx_library.size()])

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

func _on_play_sfx_requested(sfx_key: String, bus: String = SFX_BUS_NAME, manager_node: Node = self):
	play_sfx_by_key(sfx_key, bus)

func _on_play_music_requested(music_key: String):
	play_music_by_key(music_key)

func stop_music():
	_music_player.stop()

func _select_and_play_random_playlist():
	if _music_playlist_keys.is_empty():
		printerr("CafeAudioManager: No music playlists found to play.")
		return

	_current_playlist_key = _music_playlist_keys.pick_random()
	play_music_requested.emit(_current_playlist_key)

func play_playlist(playlist_key: String):
	if not audio_config.music_playlists.has(playlist_key):
		printerr("CafeAudioManager: Playlist '%s' not found." % playlist_key)
		return

	_current_playlist_key = playlist_key
	_current_playlist_track_index = 0
	_play_current_playlist_track()

func next_track():
	if _current_playlist_key.is_empty() or not audio_config.music_playlists.has(_current_playlist_key):
		printerr("CafeAudioManager: Nenhuma playlist ativa ou playlist não encontrada.")
		return

	var playlist_data = audio_config.music_playlists[_current_playlist_key]
	var tracks = playlist_data["tracks"]
	var mode = playlist_data["mode"]

	if tracks.is_empty():
		printerr("CafeAudioManager: Playlist '%s' está vazia." % _current_playlist_key)
		return

	match mode:
		AudioConfig.PlaybackMode.SEQUENTIAL:
			_current_playlist_track_index = (_current_playlist_track_index + 1) % tracks.size()
		AudioConfig.PlaybackMode.RANDOM:
			_current_playlist_track_index = randi() % tracks.size()
		AudioConfig.PlaybackMode.REPEAT_ONE:
			pass # Permanece na mesma faixa

	_play_current_playlist_track()

func previous_track():
	if _current_playlist_key.is_empty() or not audio_config.music_playlists.has(_current_playlist_key):
		printerr("CafeAudioManager: Nenhuma playlist ativa ou playlist não encontrada.")
		return

	var playlist_data = audio_config.music_playlists[_current_playlist_key]
	var tracks = playlist_data["tracks"]

	if tracks.is_empty():
		printerr("CafeAudioManager: Playlist '%s' está vazia." % _current_playlist_key)
		return

	_current_playlist_track_index = (_current_playlist_track_index - 1 + tracks.size()) % tracks.size()
	_play_current_playlist_track()

func set_playlist_mode(mode: int):
	if _current_playlist_key.is_empty() or not audio_config.music_playlists.has(_current_playlist_key):
		printerr("CafeAudioManager: Nenhuma playlist ativa ou playlist não encontrada.")
		return

	var playlist_data = audio_config.music_playlists[_current_playlist_key]
	playlist_data["mode"] = mode
	# Não precisa salvar o AudioConfig aqui, pois a edição é feita no editor

func _play_current_playlist_track():
	if _current_playlist_key.is_empty() or not audio_config.music_playlists.has(_current_playlist_key):
		printerr("CafeAudioManager: Nenhuma playlist ativa ou playlist não encontrada para tocar.")
		return

	var playlist_data = audio_config.music_playlists[_current_playlist_key]
	var tracks = playlist_data["tracks"]

	if tracks.is_empty():
		printerr("CafeAudioManager: Playlist '%s' está vazia. Não há faixas para tocar." % _current_playlist_key)
		_music_player.stop()
		return

	if _current_playlist_track_index < 0 or _current_playlist_track_index >= tracks.size():
		printerr("CafeAudioManager: Índice de faixa inválido na playlist '%s'." % _current_playlist_key)
		_music_player.stop()
		return

	var track_path = tracks[_current_playlist_track_index]
	var music_stream = load(track_path)

	if music_stream == null:
		printerr("CafeAudioManager: Falha ao carregar faixa de música: '%s' na playlist '%s'." % [track_path, _current_playlist_key])
		_music_player.stop()
		return

	if _music_player.stream == music_stream and _music_player.playing:
		return

	_music_player.stream = music_stream
	_music_player.volume_db = linear_to_db(audio_config.music_volume) if audio_config else 0.0
	_music_player.play()
	music_track_changed.emit(track_path.get_file().get_basename())

func apply_volume_to_bus(bus_name: String, linear_volume: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	if bus_index != -1:
		var db_volume = linear_to_db(linear_volume) if linear_volume > 0 else -80.0
		AudioServer.set_bus_volume_db(bus_index, db_volume)
		volume_changed.emit(bus_name, linear_volume)
	else:
		printerr("CafeAudioManager: Audio bus '%s' not found." % bus_name)

func _on_music_finished():
	next_track() # Avança para a próxima faixa na playlist

func _on_music_change_timer_timeout():
	# Se houver uma playlist ativa, o timer pode ser usado para avançar a faixa
	if not _current_playlist_key.is_empty():
		next_track()
	else:
		_select_and_play_random_playlist() # Fallback para o comportamento antigo se não houver playlist

func _on_sfx_player_finished(player: AudioStreamPlayer):
	player.stream = null

# Novos métodos de reprodução e controle de volume
func play_sfx_by_key(sfx_key: String, bus: String = SFX_BUS_NAME, volume_db: float = 0.0, pitch_scale: float = 1.0):
	if not _sfx_library.has(sfx_key):
		printerr("CafeAudioManager: SFX key not found in library: '%s'" % sfx_key)
		return

	var sfx_uids = _sfx_library[sfx_key]
	if sfx_uids.is_empty():
		printerr("CafeAudioManager: SFX category '%s' is empty." % sfx_key)
		return
	
	var random_uid_str = sfx_uids.pick_random()
	var uid_int = random_uid_str.replace("uid://", "").to_int()
	var resource_path = ResourceUID.get_id_path(uid_int)

	if resource_path.is_empty():
		printerr("CafeAudioManager: Failed to get resource path for SFX UID: '%s'" % random_uid_str)
		return

	var sound_stream = load(resource_path)

	if sound_stream == null:
		printerr("CafeAudioManager: Failed to load SFX stream from path: '%s' (UID: '%s')" % [resource_path, random_uid_str])
		return

	for player in _sfx_players:
		if not player.playing:
			player.stream = sound_stream
			player.bus = bus
			player.volume_db = volume_db
			player.pitch_scale = pitch_scale
			player.play()
			return

func play_music_by_key(music_key: String, volume_db: float = 0.0, pitch_scale: float = 1.0):
	if not _music_library.has(music_key):
		printerr("CafeAudioManager: Music key not found in library: '%s'" % music_key)
		return

	var music_uids = _music_library[music_key]
	if music_uids.is_empty():
		printerr("CafeAudioManager: Music category '%s' is empty." % music_key)
		return

	var random_uid_str = music_uids.pick_random()
	var uid_int = random_uid_str.replace("uid://", "").to_int()
	var resource_path = ResourceUID.get_id_path(uid_int)

	if resource_path.is_empty():
		printerr("CafeAudioManager: Failed to get resource path for UID: '%s'" % random_uid_str)
		return

	var music_stream = load(resource_path)

	if music_stream == null:
		printerr("CafeAudioManager: Failed to load music stream from path: '%s' (UID: '%s')" % [resource_path, random_uid_str])
		return

	if _music_player.stream == music_stream and _music_player.playing:
		return

	_music_player.stream = music_stream
	_music_player.volume_db = volume_db
	_music_player.pitch_scale = pitch_scale
	_music_player.play()
	music_track_changed.emit(music_key)

func stop_all_sfx():
	for player in _sfx_players:
		player.stop()

func set_sfx_volume(volume: float):
	apply_volume_to_bus(SFX_BUS_NAME, volume)

func set_music_volume(volume: float):
	apply_volume_to_bus(MUSIC_BUS_NAME, volume)

func set_master_volume(volume: float):
	apply_volume_to_bus("Master", volume)

# Métodos para outros scripts consultarem as configurações atuais
func get_sfx_paths() -> Array[String]:
	return audio_config.sfx_paths if audio_config else []

func get_music_paths() -> Array[String]:
	return audio_config.music_paths if audio_config else []

func get_default_click_key() -> String:
	return audio_config.default_click_key if audio_config else ""

func get_default_hover_key() -> String:
	return audio_config.default_hover_key if audio_config else ""

func get_default_slider_key() -> String:
	return audio_config.default_slider_key if audio_config else ""