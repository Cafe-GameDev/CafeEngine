@tool
class_name SFXButton extends Button

# Este script é um componente reutilizável para todos os botões da UI.
# Ele adiciona automaticamente feedback sonoro para hover e clique.

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var click_sfx_key: String = "ui_click" # Chave padrão para o SFX de clique
@export var hover_sfx_key: String = "ui_rollover" # Chave padrão para o SFX de hover

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta os sinais para feedback sonoro
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_pressed():
	if not click_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(click_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	# Opcional: Adicionar lógica para quando o mouse sai, se necessário.
	pass
