extends Resource
class_name PerkData

@export var perk_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var effects: Array[Resource] # Array of EffectData
@export var required_level: int = 1
@export var prerequisites: Array[String] # Array of PerkData IDs