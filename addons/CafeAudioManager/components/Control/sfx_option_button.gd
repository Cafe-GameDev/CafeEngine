@tool
class_name SFXOptionButton extends OptionButton

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var item_selected_sfx_key: String = "ui_click" # Chave para o SFX de item selecionado
@export var hover_sfx_key: String = "ui_rollover" # Chave para o SFX de hover

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta os sinais para feedback sonoro
	item_selected.connect(_on_item_selected)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_item_selected(index: int):
	if not item_selected_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(item_selected_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	# Opcional: Adicionar lógica para quando o mouse sai, se necessário.
	pass
