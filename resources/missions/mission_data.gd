extends Resource
class_name MissionData

enum MissionObjectiveType { KILL_TARGET, COLLECT_ITEM, REACH_LOCATION, STEALTH_KILL, ESCORT_NPC, CUSTOM }

class MissionObjective extends Resource:
	@export var objective_type: MissionObjectiveType = MissionObjectiveType.CUSTOM
	@export var description: String = ""
	@export var target_id: String = "" # e.g., enemy_id, item_id, npc_id, scene_path
	@export var required_amount: int = 1
	@export var current_amount: int = 0
	@export var is_completed: bool = false

class MissionStage extends Resource:
	@export var stage_name: String = ""
	@export var description: String = ""
	@export var objectives: Array[MissionObjective]
	@export var next_stage_id: String = "" # ID of the next stage, if linear
	@export var branching_stages: Dictionary # Dictionary mapping condition to stage ID for branching

@export var mission_id: String = ""
@export var mission_name: String = ""
@export var description: String = ""
@export var stages: Array[MissionStage]
@export var rewards_items: Array[String] # Array of item IDs
@export var rewards_experience: int = 0
@export var rewards_currency: int = 0
@export var prerequisites_missions: Array[String] # Array of mission IDs
@export var failure_conditions: Array[String] # e.g., "target_escaped", "player_detected"