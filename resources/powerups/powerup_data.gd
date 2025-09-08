extends Resource
class_name PowerUpData

@export var powerup_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var duration: float = 0.0 # 0.0 for instant, >0 for timed power-up
@export var effects: Array[Resource] # Array of EffectData
@export var transformation_scene_path: String = "" # Path to a scene for visual transformation