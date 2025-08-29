@tool
class_name SFXColorPicker extends ColorPicker

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var color_changed_sfx_key: String = "ui_color_change" # Chave para o SFX de mudança de cor
@export var hover_sfx_key: String = "ui_rollover" # Chave para o SFX de hover

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta os sinais para feedback sonoro
	color_changed.connect(_on_color_changed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_color_changed(color: Color):
	if not color_changed_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(color_changed_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	# Opcional: Adicionar lógica para quando o mouse sai, se necessário.
	pass
