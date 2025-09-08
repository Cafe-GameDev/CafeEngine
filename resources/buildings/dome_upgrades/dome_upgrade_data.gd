extends Resource
class_name DomeUpgradeData

class ResourceCost extends Resource:
	@export var resource_data: Resource # Reference to MiningResourceData
	@export var quantity: int = 1

@export var upgrade_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var cost: Array[ResourceCost]
@export var build_time: float = 0.0
@export var effects: Array[Resource] # Array of EffectData
@export var prerequisites: Array[String] # Array of DomeUpgradeData IDs