extends Resource
class_name CharacterData

@export var character_name: String = ""
@export var max_health: float = 100.0
@export var current_health: float = 100.0

# Core Stats
@export var strength: int = 10
@export var dexterity: int = 10
@export var intelligence: int = 10
@export var constitution: int = 10
@export var luck: int = 10

# Combat Stats
@export var physical_defense: float = 0.0
@export var magical_defense: float = 0.0
@export var evasion_chance: float = 0.0
@export var accuracy: float = 0.0

# Resource Pools
@export var max_mana: float = 0.0
@export var current_mana: float = 0.0
@export var mana_regeneration: float = 0.0
@export var max_stamina: float = 0.0
@export var current_stamina: float = 0.0
@export var stamina_regeneration: float = 0.0