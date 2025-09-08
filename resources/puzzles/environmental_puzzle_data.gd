extends Resource
class_name EnvironmentalPuzzleData

class PuzzleStep extends Resource:
	@export var step_description: String = ""
	@export var required_action: String = "" # e.g., "activate_lever", "push_block"
	@export var target_id: String = "" # ID of the object to interact with

@export var puzzle_name: String = ""
@export var description: String = ""
@export var location: Vector3 = Vector3.ZERO
@export var solution_steps: Array[PuzzleStep]
@export var rewards_items: Array[String] # Array of ItemData IDs
@export var unlocked_abilities: Array[Resource] # Array of TraversalAbilityData or SkillData