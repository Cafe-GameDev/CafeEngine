extends Resource
class_name UpgradeData

enum UpgradeType { MOVEMENT, COMBAT, UTILITY, STAT_BOOST }

@export var upgrade_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var upgrade_type: UpgradeType = UpgradeType.STAT_BOOST
@export var effects: Array[Resource] # Array of EffectData resources applied by this upgrade
@export var prerequisites: Array[String] # List of upgrade IDs that must be unlocked first