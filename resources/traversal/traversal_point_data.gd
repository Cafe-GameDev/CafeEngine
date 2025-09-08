extends Resource
class_name TraversalPointData

enum TraversalType { CLIMB_LEDGE, JUMP_POINT, ZIPLINE_START, ZIPLINE_END, WALL_RUN_START, WALL_RUN_END }

@export var point_id: String = ""
@export var description: String = ""
@export var type: TraversalType = TraversalType.CLIMB_LEDGE
@export var required_skill: Resource # Reference to UpgradeData or SkillData