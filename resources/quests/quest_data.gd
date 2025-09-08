extends Resource
class_name QuestData

enum ObjectiveType { KILL_ENEMIES, COLLECT_ITEMS, REACH_LOCATION, TALK_TO_NPC, CUSTOM }

class Objective extends Resource:
	@export var objective_type: ObjectiveType = ObjectiveType.CUSTOM
	@export var description: String = ""
	@export var target_id: String = "" # e.g., enemy_id, item_id, npc_id, scene_path
	@export var required_amount: int = 1
	@export var current_amount: int = 0
	@export var is_completed: bool = false

@export var quest_name: String = ""
@export var description: String = ""
@export var objectives: Array[Objective]
@export var rewards_items: Array[String] # Array of item IDs
@export var rewards_experience: int = 0
@export var rewards_currency: int = 0
@export var prerequisites_quests: Array[String] # Array of quest IDs
@export var is_main_quest: bool = false
@export var is_repeatable: bool = false