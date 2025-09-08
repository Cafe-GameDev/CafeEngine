extends Resource
class_name RoomData

enum HazardType { SPIKES, LAVA, POISON_GAS, FALLING_OBJECTS }

@export var room_name: String = ""
@export var description: String = ""
@export var background_music_path: String = ""
@export var environmental_hazards: Array[HazardType] # Array of HazardType enums
@export var enemy_spawns: Array[Resource] # Array of EnemyData resources
@export var collectibles_in_room: Array[Resource] # Array of CollectibleData resources