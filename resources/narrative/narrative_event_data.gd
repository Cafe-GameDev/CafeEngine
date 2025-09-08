extends Resource
class_name NarrativeEventData

@export var event_id: String = ""
@export var event_name: String = ""
@export var description: String = ""
@export var trigger_conditions: Array[String] # e.g., "player_enters_area_x", "quest_completed_y"
@export var dialogue_id: String = "" # Reference to DialogueData ID
@export var cutscene_path: String = "" # Path to a cutscene scene or animation
@export var rewards_items: Array[String] # Array of ItemData IDs
@export var unlocks_quests: Array[String] # Array of QuestData IDs
@export var unlocks_abilities: Array[Resource] # Array of SkillData or TraversalAbilityData