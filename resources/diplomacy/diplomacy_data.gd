extends Resource
class_name DiplomacyData

enum DiplomaticActionType { DECLARE_WAR, FORM_ALLIANCE, SEND_GIFT, INSULT, NEGOTIATE_TRADE }

@export var action_name: String = ""
@export var description: String = ""
@export var action_type: DiplomaticActionType = DiplomaticActionType.FORM_ALLIANCE
@export var cost: Array[Resource] # Array of ItemQuantity (for resources/currency)
@export var effects: Array[Resource] # Array of EffectData (on relations, stats)
@export var prerequisites: Array[String] # e.g., "reputation_friendly_with_faction_x", "has_tech_diplomacy"
@export var target_faction: Resource # Reference to FactionData