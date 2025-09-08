extends Resource
class_name NewGamePlusData

@export var ng_plus_level: int = 1
@export var enemy_health_multiplier: float = 1.0
@export var enemy_damage_multiplier: float = 1.0
@export var rewards_multiplier: float = 1.0
@export var unlocked_content: Array[Resource] # Array of ItemData or SkillData IDs unlocked in this NG+ cycle