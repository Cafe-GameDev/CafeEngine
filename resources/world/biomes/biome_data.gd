extends Resource
class_name BiomeData

@export var biome_name: String = ""
@export var description: String = ""
@export var temperature: float = 0.5 # 0.0 to 1.0
@export var humidity: float = 0.5 # 0.0 to 1.0
@export var terrain_generation_rules: Resource # Reference to ProceduralGenerationRuleData
@export var spawnable_creatures: Array[Resource] # Array of CreatureData
@export var unique_resources: Array[Resource] # Array of ResourceNodeData