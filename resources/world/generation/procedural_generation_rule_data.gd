extends Resource
class_name ProceduralGenerationRuleData

enum GenerationType { TERRAIN, STRUCTURES, VEGETATION, CAVES, DUNGEONS, CUSTOM }

@export var rule_name: String = ""
@export var description: String = ""
@export var generation_type: GenerationType = GenerationType.CUSTOM
@export var parameters: Dictionary # Dictionary of rule-specific parameters (e.g., noise_scale, density)