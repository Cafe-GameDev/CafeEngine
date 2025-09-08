extends Resource
class_name CharmData

@export var charm_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var notch_cost: int = 0
@export var effects: Array[Resource] # Array of EffectData
@export var is_fragile: bool = false
@export var is_unbreakable: bool = false