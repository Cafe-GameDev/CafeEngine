extends Resource
class_name GuildData

@export var guild_id: String = ""
@export var guild_name: String = ""
@export var description: String = ""
@export var leader_id: String = "" # Player ID
@export var members: Array[String] # Array of player IDs
@export var level: int = 1
@export var experience: int = 0
@export var perks: Array[Resource] # Array of PerkData for guild-wide bonuses