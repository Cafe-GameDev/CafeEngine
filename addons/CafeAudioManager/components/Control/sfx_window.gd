@tool
extends Window

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var close_requested_sfx_key: String = "ui_close"
@export var hover_sfx_key: String = "ui_rollover"

func _ready():
	if Engine.is_editor_hint():
		return

	close_requested.connect(_on_close_requested)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_close_requested():
	if not close_requested_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(close_requested_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	pass
