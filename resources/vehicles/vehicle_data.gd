extends Resource
class_name VehicleData

enum VehicleType { LAND, AIR, WATER, MOUNT }

@export var vehicle_name: String = ""
@export var description: String = ""
@export var model_path: String = ""
@export var vehicle_type: VehicleType = VehicleType.LAND
@export var max_speed: float = 10.0
@export var acceleration: float = 1.0
@export var handling: float = 1.0
@export var fuel_type: Resource # Reference to ItemData for fuel
@export var max_fuel: float = 100.0
@export var abilities: Array[Resource] # Array of SkillData for vehicle-specific actions