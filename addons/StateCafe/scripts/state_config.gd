@tool
extends Resource
class_name StateConfig

signal config_changed

func _save_and_emit_changed():
	if ResourceSaver.save(self, self.resource_path) != OK:
		push_error("Falha ao salvar StateConfig.tres")
	emit_signal("config_changed")
