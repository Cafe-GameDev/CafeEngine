@tool
extends LineEdit

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var text_submitted_sfx_key: String = "ui_text_submit"
@export var hover_sfx_key: String = "ui_rollover"

func _ready():
	if Engine.is_editor_hint():
		return

	text_submitted.connect(_on_text_submitted)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_text_submitted(new_text: String):
	if not text_submitted_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(text_submitted_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	pass