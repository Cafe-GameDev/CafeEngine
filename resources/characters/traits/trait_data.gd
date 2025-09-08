extends Resource
class_name TraitData

@export var trait_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var effects: Array[Resource] # Array of EffectData
@export var is_positive: bool = true
@export var is_negative: bool = false
@export var conflicting_traits: Array[String] # Array of TraitData IDs