@tool
class_name SFXPopupMenu
extends PopupMenu

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var id_pressed_sfx_key: String = "ui_click"
@export var hover_sfx_key: String = "ui_rollover"

func _ready():
	if Engine.is_editor_hint():
		return

	id_pressed.connect(_on_id_pressed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_id_pressed(id: int):
	if not id_pressed_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(id_pressed_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	pass