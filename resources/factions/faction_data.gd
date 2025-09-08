extends Resource
class_name FactionData

enum Alignment { GOOD, EVIL, NEUTRAL }
enum ReputationLevel { HOSTILE, UNFRIENDLY, NEUTRAL, FRIENDLY, ALLY }

@export var faction_name: String = ""
@export var description: String = ""
@export var alignment: Alignment = Alignment.NEUTRAL
@export var relationships: Dictionary # Dictionary mapping other FactionData IDs to ReputationLevel
@export var leader_npc: Resource # Reference to NPCData