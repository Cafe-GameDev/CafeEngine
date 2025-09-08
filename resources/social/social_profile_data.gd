extends Resource
class_name SocialProfileData

@export var player_id: String = ""
@export var display_name: String = ""
@export var avatar_path: String = ""
@export var level: int = 1
@export var friends_list: Array[String] # Array of player_ids
@export var guild_id: String = "" # GuildData ID