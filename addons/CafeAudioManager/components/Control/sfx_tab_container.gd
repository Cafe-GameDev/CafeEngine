@tool
extends TabContainer

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var tab_changed_sfx_key: String = "ui_tab_change"
@export var hover_sfx_key: String = "ui_rollover"

func _ready():
	if Engine.is_editor_hint():
		return

	tab_changed.connect(_on_tab_changed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_tab_changed(tab: int):
	if not tab_changed_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(tab_changed_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	pass