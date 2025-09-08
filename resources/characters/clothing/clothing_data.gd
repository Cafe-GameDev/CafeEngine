extends Resource
class_name ClothingData

enum ClothingSlot { HEAD, TORSO, LEGS, FEET, HANDS, ACCESSORY, FULL_BODY }

@export var clothing_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var slot_type: ClothingSlot = ClothingSlot.FULL_BODY
@export var model_path: String = "" # Path to 3D model or 2D texture for the clothing item
@export var cost: int = 0
@export var stat_bonuses: Array[Resource] # Array of EffectData