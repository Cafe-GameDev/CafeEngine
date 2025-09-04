@tool
extends Resource
class_name CoreConfig

signal config_changed

@export var enable_camera: bool = true:
	set(value):
		if enable_camera != value:
			enable_camera = value
			_save_and_emit_changed()
@export var enable_console: bool = true:
	set(value):
		if enable_console != value:
			enable_console = value
			_save_and_emit_changed()
@export var enable_tests: bool = true:
	set(value):
		if enable_tests != value:
			enable_tests = value
			_save_and_emit_changed()
@export var enable_data: bool = true:
	set(value):
		if enable_data != value:
			enable_data = value
			_save_and_emit_changed()
@export var enable_dialogue: bool = true:
	set(value):
		if enable_dialogue != value:
			enable_dialogue = value
			_save_and_emit_changed()
@export var enable_display: bool = true:
	set(value):
		if enable_display != value:
			enable_display = value
			_save_and_emit_changed()
@export var enable_event: bool = true:
	set(value):
		if enable_event != value:
			enable_event = value
			_save_and_emit_changed()
@export var enable_mobile: bool = true:
	set(value):
		if enable_mobile != value:
			enable_mobile = value
			_save_and_emit_changed()
@export var enable_pool: bool = true:
	set(value):
		if enable_pool != value:
			enable_pool = value
			_save_and_emit_changed()
@export var enable_save: bool = true:
	set(value):
		if enable_save != value:
			enable_save = value
			_save_and_emit_changed()
@export var enable_settings: bool = true:
	set(value):
		if enable_settings != value:
			enable_settings = value
			_save_and_emit_changed()
@export var enable_transition: bool = true:
	set(value):
		if enable_transition != value:
			enable_transition = value
			_save_and_emit_changed()

func _save_and_emit_changed():
	# Don't try to save if the resource doesn't have a path yet.
	# The creator of the resource is responsible for the initial save.
	if resource_path.is_empty():
		emit_signal("config_changed")
		return

	# Garante que o recurso seja salvo no disco
	if ResourceSaver.save(self, self.resource_path) != OK:
		push_error("Falha ao salvar CoreConfig.tres")
	emit_signal("config_changed")