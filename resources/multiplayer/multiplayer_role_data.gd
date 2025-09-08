extends Resource
class_name MultiplayerRoleData

@export var role_name: String = ""
@export var description: String = ""
@export var abilities: Array[Resource] # Array of SkillData
@export var starting_gear: Array[String] # Array of ItemData IDs
@export var max_players_per_role: int = 1