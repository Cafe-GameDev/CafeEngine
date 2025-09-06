@tool
extends Resource
class_name AudioConfig

signal config_changed

@export var is_panel_expanded: bool = false:
	set(value):
		if is_panel_expanded != value:
			is_panel_expanded = value
			_save_and_emit_changed()

@export var music_data: Dictionary = {}
@export var sfx_data: Dictionary = {}

@export var sfx_paths: Array[String] = ["res://addons/AudioCafe/assets/sfx"]:
	set(value):
		if sfx_paths != value:
			sfx_paths = value
			_save_and_emit_changed()

@export var music_paths: Array[String] = ["res://addons/AudioCafe/assets/music"]:
	set(value):
		if music_paths != value:
			music_paths = value
			_save_and_emit_changed()

@export var default_click_key: String = "ui_click":
	set(value):
		if default_click_key != value:
			default_click_key = value
			_save_and_emit_changed()

@export var default_hover_key: String = "ui_rollover":
	set(value):
		if default_hover_key != value:
			default_hover_key = value
			_save_and_emit_changed()

@export var default_slider_key: String = "ui_slider_changed":
	set(value):
		if default_slider_key != value:
			default_slider_key = value
			_save_and_emit_changed()

@export_group("Volume Settings")
@export_range(0.0, 1.0, 0.01) var master_volume: float = 1.0:
	set(value):
		if master_volume != value:
			master_volume = value
			_save_and_emit_changed()

@export_range(0.0, 1.0, 0.01) var sfx_volume: float = 1.0:
	set(value):
		if sfx_volume != value:
			sfx_volume = value
			_save_and_emit_changed()

@export_range(0.0, 1.0, 0.01) var music_volume: float = 1.0:
	set(value):
		if music_volume != value:
			music_volume = value
			_save_and_emit_changed()



func _save_and_emit_changed():
	if self.resource_path:
		var dir = self.resource_path.get_base_dir()
		if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(dir)):
			DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(dir))
		
		var error = ResourceSaver.save(self, self.resource_path)
		if error != OK:
			push_error("Failed to save AudioConfig resource: %s" % error)
	emit_changed()
	emit_signal("config_changed")
