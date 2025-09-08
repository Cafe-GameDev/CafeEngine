extends Resource
class_name ToolData

enum FunctionalityType { MINING, CUTTING, INTERACTION, UTILITY }

@export var tool_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var max_durability: float = 100.0
@export var current_durability: float = 100.0
@export var functionality_type: FunctionalityType = FunctionalityType.UTILITY
@export var power_level: float = 1.0
@export var required_skill_level: int = 0