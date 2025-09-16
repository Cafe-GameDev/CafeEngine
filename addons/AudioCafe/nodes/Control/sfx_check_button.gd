@tool
class_name SFXCheckButton
extends CheckButton

@export_group("SFX Settings")
@export var pressed_sfx_key: String
@export var hover_sfx_key: String

func _ready():
	if Engine.is_editor_hint():
		return

	if CafeAudioManager:
		CafeAudioManager.audio_config_updated.connect(Callable(self, "_on_audio_config_updated"))
		_on_audio_config_updated(CafeAudioManager.audio_config)

	toggled.connect(_on_toggled)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_toggled(button_pressed: bool):
	if not pressed_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(pressed_sfx_key, "SFX", self, false, false, 0.0)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self, false, false, 0.0)

func _on_mouse_exited():
	pass

func _on_audio_config_updated(config: AudioConfig):
	if pressed_sfx_key.is_empty():
		pressed_sfx_key = config.default_toggle_key
	if hover_sfx_key.is_empty():
		hover_sfx_key = config.default_hover_key
