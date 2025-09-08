extends Resource
class_name ResourceDefinitionData

enum ResourceType { CURRENCY, RAW_MATERIAL, MANUFACTURED_GOOD, SCIENCE, FOOD, LUXURY, MILITARY }

@export var resource_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var type: ResourceType = ResourceType.RAW_MATERIAL
@export var base_value: float = 1.0