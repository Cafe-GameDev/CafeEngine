extends Resource
class_name BulletPatternData

@export var pattern_name: String = ""
@export var description: String = ""
@export var bullet_scene_path: String = ""
@export var fire_rate: float = 0.1 # Seconds between bullets
@export var bullet_speed: float = 500.0
@export var spread_angle: float = 0.0 # Degrees
@export var number_of_bullets: int = 1
@export var duration: float = 0.0 # 0.0 for instant, >0 for continuous fire
@export var effects_on_hit: Array[Resource] # Array of EffectData