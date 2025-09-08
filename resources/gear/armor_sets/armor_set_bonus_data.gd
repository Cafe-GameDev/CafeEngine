extends Resource
class_name ArmorSetBonusData

@export var set_name: String = ""
@export var description: String = ""
@export var required_pieces: Array[String] # Array of SuitData IDs
@export var bonuses: Dictionary # Dictionary mapping number of pieces (int) to Array of EffectData