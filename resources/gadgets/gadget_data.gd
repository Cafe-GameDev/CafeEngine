extends Resource
class_name GadgetData

@export var gadget_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var ammo_type: Resource # Reference to ItemData for ammo
@export var max_ammo: int = 0
@export var cooldown: float = 0.0
@export var effects: Array[Resource] # Array of EffectData applied on use
@export var visual_effect_path: String = ""
@export var sound_effect_path: String = ""