@tool
class_name SFXTabContainer extends TabContainer

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var tab_changed_sfx_key: String = "ui_tab_change" # Chave para o SFX de mudança de aba
@export var hover_sfx_key: String = "ui_rollover" # Chave para o SFX de hover (na área do container)

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta os sinais para feedback sonoro
	tab_changed.connect(_on_tab_changed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_tab_changed(tab: int):
	if not tab_changed_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(tab_changed_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	# Opcional: Adicionar lógica para quando o mouse sai, se necessário.
	pass
