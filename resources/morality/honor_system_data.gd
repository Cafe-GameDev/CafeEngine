extends Resource
class_name HonorSystemData

enum HonorLevel { DISHONORABLE, NEUTRAL, HONORABLE }

@export var honor_level_name: String = ""
@export var description: String = ""
@export var score_threshold: int = 0
@export var rewards: Array[Resource] # Array of ItemData or SkillData
@export var penalties: Array[Resource] # Array of EffectData