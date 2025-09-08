extends Resource
class_name ResearchData

@export var tech_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var cost: int = 0
@export var prerequisites: Array[String] # Array of ResearchData IDs
@export var unlocks_buildings: Array[String] # Array of BuildingData IDs
@export var unlocks_units: Array[String] # Array of UnitData IDs
@export var unlocks_abilities: Array[String] # Array of AbilityData IDs