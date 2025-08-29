@tool
class_name SFXTextureProgressBar extends TextureProgressBar

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx" # Biblioteca padrão para SFX
@export var value_changed_sfx_key: String = "ui_progress_change" # Chave para o SFX de mudança de valor

var _previous_value: float # Para detectar mudança de valor

func _ready():
	if Engine.is_editor_hint():
		return

	_previous_value = value
	# Conecta o sinal para feedback sonoro
	value_changed.connect(_on_value_changed)

func _on_value_changed(new_value: float):
	# Só emite SFX se o valor realmente mudou e não é o valor inicial
	if not value_changed_sfx_key.is_empty() and new_value != _previous_value:
		CafeAudioManager.play_sfx_requested.emit(value_changed_sfx_key, "SFX", self)
	_previous_value = new_value
