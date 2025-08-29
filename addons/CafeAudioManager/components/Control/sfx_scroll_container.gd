@tool
class_name SFXScrollContainer extends ScrollContainer

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var scrolled_sfx_key: String = "ui_scroll" # Chave para o SFX de rolagem
@export var hover_sfx_key: String = "ui_rollover" # Chave para o SFX de hover

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta os sinais para feedback sonoro
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

	# Conecta os sinais das barras de rolagem internas, se existirem
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
	# Opcional: Adicionar lógica para quando o mouse sai, se necessário.
	pass
