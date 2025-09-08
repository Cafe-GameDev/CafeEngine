extends Resource
class_name SpellData

@export var spell_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var mana_cost: float = 0.0
@export var cast_time: float = 0.0
@export var cooldown: float = 0.0
@export var range: float = 0.0
@export var area_of_effect_radius: float = 0.0
@export var effects: Array[Resource] # Array of EffectData
@export var visual_effect_path: String = ""
@export var sound_effect_path: String = ""
@export var min_level_required: int = 1
@export var required_intelligence: int = 0