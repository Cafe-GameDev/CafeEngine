extends Resource
class_name PlayerSkillTreeData

# Represents a single node in the skill tree
class SkillTreeNode extends Resource:
	@export var skill_id: String = "" # Unique ID for the skill
	@export var skill_data: SkillData # Reference to the actual skill data
	@export var prerequisites: Array[String] # List of skill_ids that must be unlocked first
	@export var unlocked: bool = false # Whether this skill node is unlocked by the player
	@export var position: Vector2 = Vector2.ZERO # Position for visual representation in a skill tree UI

@export var tree_name: String = "Player Skill Tree"
@export var skill_nodes: Array[SkillTreeNode] # All skill nodes in this tree