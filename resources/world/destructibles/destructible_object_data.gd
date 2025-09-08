extends Resource
class_name DestructibleObjectData

@export var object_name: String = ""
@export var description: String = ""
@export var model_path: String = "" # Path to 3D model or 2D scene
@export var initial_health: float = 100.0
@export var loot_on_destroy: Array[Resource] # Array of ItemData IDs
@export var destruction_effect_path: String = "" # Path to a scene or animation for destruction effect