@tool
extends CheckButton

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var pressed_sfx_key: String = "ui_click"
@export var hover_sfx_key: String = "ui_rollover"

func _ready():
	if Engine.is_editor_hint():
		return

	toggled.connect(_on_toggled)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_toggled(button_pressed: bool):
	if not pressed_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(pressed_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	pass
