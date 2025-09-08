extends Resource
class_name NPCData

enum NPCRole { MERCHANT, QUEST_GIVER, TOWNSFOLK, ENEMY, FRIENDLY }

@export var npc_name: String = ""
@export var description: String = ""
@export var character_model_path: String = ""
@export var dialogue_id: String = "" # Reference to DialogueData ID
@export var role: NPCRole = NPCRole.TOWNSFOLK
@export var abilities: Array[Resource] # Array of SkillData
@export var inventory_items: Array[String] # Array of item IDs that NPC has