extends Resource
class_name BossEncounterData

@export var encounter_name: String = ""
@export var description: String = ""
@export var boss_character: Resource # Reference to EnemyData
@export var phases: Array[Resource] # Array of BossPhaseData
@export var arena_scene_path: String = ""
@export var rewards_items: Array[String] # Array of ItemData IDs
@export var rewards_experience: int = 0
@export var rewards_currency: int = 0