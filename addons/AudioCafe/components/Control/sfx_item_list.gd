@tool
class_name SFXItemList
extends ItemList

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var item_selected_sfx_key: String
@export var hover_sfx_key: String

func _ready():
	if Engine.is_editor_hint():
		return

	# Conecta ao sinal de atualização do AudioConfig do CafeAudioManager
	if CafeAudioManager:
		CafeAudioManager.audio_config_updated.connect(Callable(self, "_on_audio_config_updated"))
		# Aplica as configurações iniciais
		_on_audio_config_updated(CafeAudioManager.audio_config)

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
	pass

func _on_audio_config_updated(config: AudioConfig):
	# Atualiza as chaves de SFX com base na configuração atualizada
	# Apenas se a chave exportada estiver vazia, usa a padrão do AudioConfig
	if item_selected_sfx_key.is_empty():
		item_selected_sfx_key = config.default_click_key # Usando default_click_key para seleção de item
	if hover_sfx_key.is_empty():
		hover_sfx_key = config.default_hover_key