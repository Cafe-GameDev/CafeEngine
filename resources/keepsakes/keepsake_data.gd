extends Resource
class_name KeepsakeData

@export var keepsake_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var effects: Array[Resource] # Array of EffectData
@export var unlocked_by_npc: String = "" # NPCData ID
@export var unlocked_by_challenge: String = "" # ChallengeData ID