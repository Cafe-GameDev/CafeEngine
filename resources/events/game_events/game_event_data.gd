extends Resource
class_name GameEventData

@export var event_id: String = ""
@export var description: String = ""
@export var effects_on_trigger: Array[Resource] # Array of EffectData
@export var parameters: Dictionary # Dictionary for event-specific data (e.g., target_id, amount)