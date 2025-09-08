extends Resource
class_name BlockData

enum ToolType { PICKAXE, AXE, SHOVEL, HAND, CUSTOM }

@export var block_name: String = ""
@export var texture_path: String = ""
@export var is_solid: bool = true
@export var is_transparent: bool = false
@export var mine_time: float = 1.0
@export var required_tool_type: ToolType = ToolType.HAND
@export var loot_on_break: Array[Resource] # Array of ItemData IDs