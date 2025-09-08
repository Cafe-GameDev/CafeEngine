extends Resource
class_name AchievementData

enum ConditionType { KILL_ENEMIES, COLLECT_ITEMS, REACH_LEVEL, COMPLETE_QUEST, CUSTOM }

@export var achievement_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var condition_type: ConditionType = ConditionType.CUSTOM
@export var condition_target_id: String = "" # e.g., enemy_id, item_id, quest_id
@export var condition_value: float = 0.0 # e.g., number of kills, level reached
@export var rewards_items: Array[String] # Array of item IDs
@export var rewards_experience: int = 0
@export var rewards_currency: int = 0