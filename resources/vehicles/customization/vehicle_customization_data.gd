extends Resource
class_name VehicleCustomizationData

enum VehiclePartSlot { ENGINE, TIRES, PAINT, SPOILER, ARMOR, WEAPON, CUSTOM }

@export var part_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var slot_type: VehiclePartSlot = VehiclePartSlot.CUSTOM
@export var stat_bonuses: Array[Resource] # Array of EffectData
@export var cost: int = 0
@export var prerequisites: Array[String] # Array of other VehicleCustomizationData IDs