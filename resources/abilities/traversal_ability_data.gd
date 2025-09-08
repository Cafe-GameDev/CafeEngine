extends Resource
class_name TraversalAbilityData

enum TraversalAbilityType { WEB_SWING, GRAPPLE, WALL_RUN, DOUBLE_JUMP, AIR_DASH, CLIMB_SPEED_BOOST }

@export var ability_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var type: TraversalAbilityType = TraversalAbilityType.DOUBLE_JUMP
@export var stamina_cost: float = 0.0
@export var cooldown: float = 0.0
@export var animation_name: String = ""