@tool
class_name SFXLineEdit extends LineEdit

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var text_submitted_sfx_key: String = "ui_text_submit" # Chave para o SFX de texto submetido
@export var hover_sfx_key: String = "ui_rollover" # Chave para o SFX de hover

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta os sinais para feedback sonoro
	text_submitted.connect(_on_text_submitted)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_text_submitted(new_text: String):
	if not text_submitted_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(text_submitted_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	# Opcional: Adicionar lógica para quando o mouse sai, se necessário.
	pass
