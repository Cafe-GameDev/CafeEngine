@tool
extends ProgressBar

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var value_changed_sfx_key: String = "ui_progress_change"

var _previous_value: float

func _ready():
	if Engine.is_editor_hint():
		return

	_previous_value = value
	value_changed.connect(_on_value_changed)

func _on_value_changed(new_value: float):
	if not value_changed_sfx_key.is_empty() and new_value != _previous_value:
		CafeAudioManager.play_sfx_requested.emit(value_changed_sfx_key, "SFX", self)
	_previous_value = new_value