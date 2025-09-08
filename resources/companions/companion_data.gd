extends Resource
class_name CompanionData

@export var companion_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var max_health: float = 100.0
@export var current_health: float = 100.0
@export var damage: float = 10.0
@export var attack_cooldown: float = 1.0
@export var abilities: Array[Resource] # Array of SkillData
@export var loyalty_level: int = 0
@export var evolution_data: Resource # Reference to another CompanionData for evolution, if applicable