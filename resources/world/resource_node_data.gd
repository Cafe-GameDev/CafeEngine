extends Resource
class_name ResourceNodeData

enum ResourceType { WOOD, STONE, METAL, PLANT, GEM, ANIMAL_PART, CUSTOM }

@export var node_name: String = ""
@export var description: String = ""
@export var resource_type: ResourceType = ResourceType.CUSTOM
@export var item_yield: Array[Resource] # Array of ItemQuantity (nested class from BuildingData)
@export var respawn_time: float = 0.0 # Time in seconds for the node to respawn
@export var required_tool: Resource # Reference to ToolData