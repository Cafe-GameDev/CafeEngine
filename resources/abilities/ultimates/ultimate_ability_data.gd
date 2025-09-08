extends Resource
class_name UltimateAbilityData

@export var ultimate_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var charge_required: float = 100.0 # Percentage of ultimate charge required
@export var duration: float = 0.0 # 0.0 for instant, >0 for timed
@export var effects: Array[Resource] # Array of EffectData
@export var animation_name: String = ""
@export var sound_effect_path: String = ""