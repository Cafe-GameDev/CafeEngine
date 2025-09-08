extends Resource
class_name ObstacleData

@export var obstacle_name: String = ""
@export var description: String = ""
@export var model_path: String = "" # Path to 3D model or 2D scene
@export var collision_shape_path: String = "" # Path to collision shape resource
@export var damage_on_contact: float = 0.0
@export var is_breakable: bool = false
@export var health: float = 0.0 # If breakable
@export var loot_on_break: Array[String] # Array of ItemData IDs