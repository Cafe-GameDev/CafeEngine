extends Resource
class_name PhysicsObjectData

@export var object_name: String = ""
@export var description: String = ""
@export var model_path: String = ""
@export var mass: float = 1.0
@export var friction: float = 0.5
@export var bounciness: float = 0.0
@export var is_grabbable: bool = false
@export var effects_on_impact: Array[Resource] # Array of EffectData