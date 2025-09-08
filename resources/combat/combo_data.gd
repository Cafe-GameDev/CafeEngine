extends Resource
class_name ComboData

@export var combo_name: String = ""
@export var description: String = ""
@export var input_sequence: Array[String] # Array of input action names (e.g., ["attack_light", "attack_light", "attack_heavy"])
@export var damage_multiplier: float = 1.0
@export var effects: Array[Resource] # Array of EffectData
@export var animation_name: String = ""