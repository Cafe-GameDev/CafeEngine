extends Resource
class_name AbilityData

enum AbilityTargetType { SELF, SINGLE_TARGET, AREA, PROJECTILE, NONE }

@export var ability_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var mana_cost: float = 0.0
@export var cooldown: float = 0.0
@export var cast_time: float = 0.0
@export var range: float = 0.0
@export var target_type: AbilityTargetType = AbilityTargetType.NONE
@export var effects: Array[Resource] # Array of EffectData
@export var animation_name: String = ""
@export var sound_effect_path: String = ""