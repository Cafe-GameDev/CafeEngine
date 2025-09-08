extends Resource
class_name SpecialInfectedData

@export var infected_name: String = ""
@export var description: String = ""
@export var model_path: String = ""
@export var abilities: Array[Resource] # Array of AbilityData
@export var weak_points: Array[String] # e.g., "head", "back"
@export var spawn_conditions: Array[String] # e.g., "wave_number_5", "player_in_dark_area"