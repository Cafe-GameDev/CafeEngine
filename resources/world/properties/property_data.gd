extends Resource
class_name PropertyData

@export var property_name: String = ""
@export var description: String = ""
@export var location: Vector3 = Vector3.ZERO
@export var cost: int = 0
@export var income_per_hour: float = 0.0
@export var storage_capacity: int = 0
@export var unlocks_features: Array[Resource] # Array of SkillData or UpgradeData