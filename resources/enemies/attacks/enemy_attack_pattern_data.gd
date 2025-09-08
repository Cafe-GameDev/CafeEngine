extends Resource
class_name EnemyAttackPatternData

class AttackAction extends Resource:
	@export var move_data: Resource # Reference to MoveData
	@export var delay_after_attack: float = 0.0

@export var pattern_name: String = ""
@export var description: String = ""
@export var sequence: Array[AttackAction]
@export var trigger_conditions: Array[String] # e.g., "player_in_range", "health_below_50_percent"