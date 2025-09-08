extends Resource
class_name SuitData

@export var suit_name: String = ""
@export var description: String = ""
@export var model_path: String = "" # Path to 3D model or 2D scene for the suit
@export var icon_path: String = ""
@export var stat_bonuses: Array[Resource] # Array of EffectData for stat boosts
@export var abilities: Array[Resource] # Array of SkillData or TraversalAbilityData
@export var crafting_cost: Array[Resource] # Array of ItemQuantity (nested class from BuildingData)