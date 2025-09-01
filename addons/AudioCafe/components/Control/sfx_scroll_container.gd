@tool
class_name SFXScrollContainer
extends ScrollContainer

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var scrolled_sfx_key: String
@export var hover_sfx_key: String

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta ao sinal de atualização do AudioConfig do CafeAudioManager
	if CafeAudioManager:
		CafeAudioManager.audio_config_updated.connect(Callable(self, "_on_audio_config_updated"))
		# Aplica as configurações iniciais
		_on_audio_config_updated(CafeAudioManager.audio_config)

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

	var h_scroll_bar = get_h_scroll_bar()
	if h_scroll_bar:
		h_scroll_bar.value_changed.connect(_on_scrolled)
	var v_scroll_bar = get_v_scroll_bar()
	if v_scroll_bar:
		v_scroll_bar.value_changed.connect(_on_scrolled)

func _on_scrolled(value: float):
	if not scrolled_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(scrolled_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	pass

func _on_audio_config_updated(config: AudioConfig):
	# Atualiza as chaves de SFX com base na configuração atualizada
	# Apenas se a chave exportada estiver vazia, usa a padrão do AudioConfig
	if scrolled_sfx_key.is_empty():
		scrolled_sfx_key = config.default_slider_key # Usando default_slider_key para rolagem
	if hover_sfx_key.is_empty():
		hover_sfx_key = config.default_hover_key
