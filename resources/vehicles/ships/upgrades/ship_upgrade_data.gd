extends Resource
class_name ShipUpgradeData

@export var upgrade_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var cost: Array[Resource] # Array of ItemQuantity (nested class from BuildingData)
@export var effects: Array[Resource] # Array of EffectData for ship stats
@export var prerequisites: Array[String] # Array of ShipUpgradeData IDs