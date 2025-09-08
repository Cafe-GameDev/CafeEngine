extends Resource
class_name PuzzleMechanismData

enum MechanismType { BUTTON, LEVER, PRESSURE_PLATE, PORTAL_SURFACE, ROTATING_PLATFORM, SLIDING_DOOR }

@export var mechanism_name: String = ""
@export var description: String = ""
@export var model_path: String = ""
@export var type: MechanismType = MechanismType.BUTTON
@export var activates_target: String = "" # ID of another PuzzleMechanismData or EnvironmentalPuzzleData
@export var required_input_item: Resource # Reference to ItemData
@export var required_input_skill: Resource # Reference to SkillData