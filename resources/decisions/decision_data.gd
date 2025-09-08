extends Resource
class_name DecisionData

class DecisionOption extends Resource:
	@export var option_text: String = ""
	@export var effects: Array[Resource] # Array of EffectData
	@export var cost: Array[Resource] # Array of ItemQuantity (for resources)

@export var decision_id: String = ""
@export var title: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var trigger_conditions: Array[String] # e.g., "player_has_money_100", "has_tech_feudalism"
@export var options: Array[DecisionOption]
@export var cooldown: float = 0.0