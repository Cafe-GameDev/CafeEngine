extends Resource
class_name VehicleUpgradeData

enum VehicleUpgradeSlot { ENGINE, TIRES, SUSPENSION, NITRO, ARMOR, WEAPON, CUSTOM }

@export var upgrade_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var slot_type: VehicleUpgradeSlot = VehicleUpgradeSlot.CUSTOM
@export var stat_bonuses: Array[Resource] # Array of EffectData
@export var cost: int = 0
@export var prerequisites: Array[String] # Array of other VehicleUpgradeData IDs