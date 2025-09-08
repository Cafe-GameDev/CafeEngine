extends Resource
class_name UnitData

@export var unit_name: String = ""
@export var description: String = ""
@export var model_path: String = ""
@export var max_health: float = 100.0
@export var damage: float = 10.0
@export var attack_range: float = 1.0
@export var movement_speed: float = 1.0
@export var cost: Array[Resource] # Array of ItemQuantity (for ResourceDefinitionData and quantity)
@export var build_time: float = 0.0
@export var abilities: Array[Resource] # Array of AbilityData
@export var faction: Resource # Reference to FactionData