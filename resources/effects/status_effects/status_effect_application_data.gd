extends Resource
class_name StatusEffectApplicationData

@export var effect_data: Resource # Reference to EffectData
@export var buildup_amount: float = 0.0 # How much buildup this application causes
@export var duration_on_apply: float = 0.0 # Duration if applied directly
@export var tick_interval: float = 0.0 # Interval for ticking effects
@export var tick_damage_multiplier: float = 1.0 # Multiplier for ticking damage/healing