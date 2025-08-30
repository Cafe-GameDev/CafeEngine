@tool
class_name SFXTextEdit
extends TextEdit

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var focus_entered_sfx_key: String = "ui_focus_enter"
@export var hover_sfx_key: String = "ui_rollover"

func _ready():
	if Engine.is_editor_hint():
		return

	focus_entered.connect(_on_focus_entered)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_focus_entered():
	if not focus_entered_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(focus_entered_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	pass
