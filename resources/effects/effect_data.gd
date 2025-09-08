extends Resource
class_name EffectData

enum EffectType { BUFF, DEBUFF, DAMAGE_OVER_TIME, HEAL_OVER_TIME, STAT_BOOST, STAT_REDUCTION }

@export var effect_name: String = ""
@export var effect_type: EffectType = EffectType.STAT_BOOST
@export var value: float = 0.0
@export var duration: float = 0.0 # 0.0 for instant or permanent effects
@export var description: String = ""
@export var apply_on_self: bool = true
@export var apply_on_target: bool = false
@export var is_stackable: bool = false
@export var max_stacks: int = 1
@export var effect_sound_path: String = ""
@export var effect_visual_path: String = ""