extends Resource
class_name MapData

@export var map_name: String = ""
@export var description: String = ""
@export var thumbnail_path: String = ""
@export var game_modes: Array[Resource] # Array of GameModeData
@export var spawn_points: Array[Vector3]
@export var health_pack_locations: Array[Vector3]