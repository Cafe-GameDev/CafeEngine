@tool
extends Resource
class_name StateConfig

signal config_changed

# Adicione aqui as propriedades de configuração do StateCafe
# Exemplo:
# @export var default_state_machine_path: String = "res://state_machines/default.tres":
# 	set(value):
# 		if default_state_machine_path != value:
# 			default_state_machine_path = value
# 			_save_and_emit_changed()

func _save_and_emit_changed():
	# Garante que o recurso seja salvo no disco
	if ResourceSaver.save(self, self.resource_path) != OK:
		push_error("Falha ao salvar StateConfig.tres")
	emit_signal("config_changed")
