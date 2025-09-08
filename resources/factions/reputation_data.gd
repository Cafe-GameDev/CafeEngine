extends Resource
class_name ReputationData

enum ReputationLevel { HOSTILE, UNFRIENDLY, NEUTRAL, FRIENDLY, ALLY }

@export var faction_id: String = ""
@export var current_reputation: float = 0.0
@export var reputation_thresholds: Dictionary # Dictionary mapping ReputationLevel (int) to score (float)
@export var rewards_at_thresholds: Dictionary # Dictionary mapping ReputationLevel (int) to Array of ItemData IDs or other rewards