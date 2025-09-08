extends Resource
class_name LevelData

@export var level_name: String = ""
@export var description: String = ""
@export var background_music_path: String = ""
@export var enemy_waves: Array[Resource] # Array of EnemyData or custom wave data
@export var boss_data: Resource # Reference to EnemyData
@export var unlocks: Array[Resource] # Array of UpgradeData or SkillData