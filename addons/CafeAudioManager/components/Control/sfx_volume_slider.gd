@tool
class_name SFXVolumeSlider extends Slider

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var value_changed_sfx_key: String = "ui_change_value" # Chave para o SFX de mudança de valor
@export var hover_sfx_key: String = "ui_rollover" # Chave para o SFX de hover

@export_group("Volume Control")
@export var audio_bus_name: String = "Master" # Nome do bus de áudio a ser controlado

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta os sinais para feedback sonoro
	value_changed.connect(_on_value_changed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

	# Inicializa o slider com o volume atual do bus
	_update_slider_from_bus_volume()

func _on_value_changed(new_value: float):
	# Emite SFX de mudança de valor
	if not value_changed_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(value_changed_sfx_key, "SFX", self)

	# Atualiza o volume do bus de áudio
	var linear_volume = new_value / max_value
	CafeAudioManager.apply_volume_to_bus(audio_bus_name, linear_volume)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	# Opcional: Adicionar lógica para quando o mouse sai, se necessário.
	pass

func _update_slider_from_bus_volume():
	var bus_index = AudioServer.get_bus_index(audio_bus_name)
	if bus_index != -1:
		var db_volume = AudioServer.get_bus_volume_db(bus_index)
		var linear_volume = db_to_linear(db_volume)
		value = linear_volume * max_value
	else:
		printerr("SFXVolumeSlider: Audio bus '%s' not found. Cannot initialize slider volume." % audio_bus_name)
