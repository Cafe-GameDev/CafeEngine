extends CharacterData
class_name EnemyData

@export var enemy_name: String = ""
@export var description: String = ""
@export var max_health: float = 100.0
@export var current_health: float = 100.0
@export var damage: float = 10.0
@export var movement_speed: float = 100.0
@export var attack_cooldown: float = 1.0
@export var experience_on_defeat: int = 10
@export var loot_table: Array[String] # Array of item IDs or paths
@export var abilities: Array[Resource] # Array of SkillData
@export var weaknesses: Array[String] # e.g., "Fire", "Ice"
@export var resistances: Array[String] # e.g., "Poison", "Physical"