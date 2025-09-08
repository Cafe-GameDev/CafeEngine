extends Resource
class_name ViewpointData

@export var viewpoint_name: String = ""
@export var description: String = ""
@export var location: Vector3 = Vector3.ZERO
@export var unlocks_map_area: Resource # Reference to MapAreaData
@export var fast_travel_enabled: bool = false
@export var cinematic_path: String = "" # Path to a cinematic scene or animation