extends Resource
class_name GadgetModuleData

@export var module_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var applies_to_gadget: Resource # Reference to GadgetData
@export var effects: Array[Resource] # Array of EffectData
@export var cost: Array[Resource] # Array of ResourceCost (nested class from DomeUpgradeData)
@export var prerequisites: Array[String] # Array of GadgetModuleData IDs