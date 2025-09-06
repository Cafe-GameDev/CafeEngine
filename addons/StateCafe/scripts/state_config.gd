@tool
extends Resource
class_name StateConfig

@export var is_panel_expanded: bool = false:
	set(value):
		if is_panel_expanded != value:
			is_panel_expanded = value
			_save_and_emit_changed()

signal config_changed

func _save_and_emit_changed():
	if ResourceSaver.save(self, self.resource_path) != OK:
		push_error("Falha ao salvar StateConfig.tres")
	emit_signal("config_changed")
