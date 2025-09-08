extends Resource
class_name WantedLevelData

@export var level_number: int = 0
@export var description: String = ""
@export var police_response_strength: float = 1.0 # Multiplier for police aggressiveness/numbers
@export var bounty_amount: int = 0
@export var duration_before_cooldown: float = 0.0 # Time before wanted level starts to drop