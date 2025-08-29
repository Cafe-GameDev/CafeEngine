@tool
class_name SFXFileDialog extends FileDialog

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var dir_selected_sfx_key: String = "ui_select" # Chave para o SFX de diretório selecionado
@export var file_selected_sfx_key: String = "ui_select" # Chave para o SFX de arquivo selecionado
@export var confirmed_sfx_key: String = "ui_confirm" # Chave para o SFX de confirmação
@export var hover_sfx_key: String = "ui_rollover" # Chave para o SFX de hover

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta os sinais para feedback sonoro
	dir_selected.connect(_on_dir_selected)
	file_selected.connect(_on_file_selected)
	confirmed.connect(_on_confirmed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_dir_selected(dir: String):
	if not dir_selected_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(dir_selected_sfx_key, "SFX", self)

func _on_file_selected(path: String):
	if not file_selected_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(file_selected_sfx_key, "SFX", self)

func _on_confirmed():
	if not confirmed_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(confirmed_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	# Opcional: Adicionar lógica para quando o mouse sai, se necessário.
	pass