extends Resource
class_name CombatStyleData

@export var style_name: String = ""
@export var description: String = ""
@export var base_damage_multiplier: float = 1.0
@export var attack_speed_multiplier: float = 1.0
@export var available_combos: Array[Resource] # Array of ComboData