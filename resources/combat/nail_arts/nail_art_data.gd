extends Resource
class_name NailArtData

@export var art_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var charge_time: float = 0.0
@export var damage_multiplier: float = 1.0
@export var effects: Array[Resource] # Array of EffectData
@export var animation_name: String = ""