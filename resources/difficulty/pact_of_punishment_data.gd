extends Resource
class_name PactOfPunishmentData

enum ModifierType { ENEMY_HEALTH, ENEMY_DAMAGE, PLAYER_HEALTH, PLAYER_DAMAGE, RESOURCE_GAIN, CUSTOM }

class PactModifier extends Resource:
	@export var modifier_type: ModifierType = ModifierType.CUSTOM
	@export var value: float = 1.0 # Multiplier or flat value
	@export var description: String = ""

@export var pact_name: String = ""
@export var description: String = ""
@export var heat_value: int = 0 # How much heat this pact adds
@export var modifiers: Array[PactModifier]