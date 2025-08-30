@tool
extends Tree

@export_group("SFX Settings")
@export var library_name: String = "plugin_sfx"
@export var item_selected_sfx_key: String = "ui_click"
@export var item_toggle_sfx_key: String = "ui_toggle"
@export var hover_sfx_key: String = "ui_rollover"

func _ready():
	if Engine.is_editor_hint():
		return

	item_selected.connect(_on_item_selected)
	item_collapsed.connect(_on_item_toggle)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_item_selected():
	if not item_selected_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(item_selected_sfx_key, "SFX", self)

func _on_item_toggle(item: TreeItem):
	if not item_toggle_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(item_toggle_sfx_key, "SFX", self)

func _on_mouse_entered():
	if not hover_sfx_key.is_empty():
		CafeAudioManager.play_sfx_requested.emit(hover_sfx_key, "SFX", self)

func _on_mouse_exited():
	pass
