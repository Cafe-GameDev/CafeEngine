extends Resource
class_name WeaponModuleDomeData

enum WeaponSlotType { WEAPON_SLOT_1, WEAPON_SLOT_2, WEAPON_SLOT_3, CUSTOM }

@export var module_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var slot_type: WeaponSlotType = WeaponSlotType.CUSTOM
@export var stat_bonuses: Array[Resource] # Array of EffectData
@export var cost: Array[Resource] # Array of ResourceCost (nested class from DomeUpgradeData)
@export var prerequisites: Array[String] # Array of WeaponModuleDomeData IDs