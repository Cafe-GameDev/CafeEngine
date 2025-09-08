extends Resource
class_name BossPhaseData

@export var phase_name: String = ""
@export var description: String = ""
@export var health_threshold_trigger: float = 0.0 # Percentage of max health to trigger phase
@export var new_abilities: Array[Resource] # Array of MoveData or SkillData
@export var visual_changes_path: String = "" # Path to a scene or animation for visual changes
@export var music_change_path: String = "" # Path to new music track