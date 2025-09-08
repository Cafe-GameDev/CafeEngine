extends Resource
class_name HeroData

enum HeroRole { TANK, DAMAGE, SUPPORT }

@export var hero_name: String = ""
@export var description: String = ""
@export var role: HeroRole = HeroRole.DAMAGE
@export var abilities: Array[Resource] # Array of AbilityData
@export var ultimate_ability: Resource # Reference to UltimateAbilityData
@export var max_health: float = 200.0
@export var armor: float = 0.0
@export var shields: float = 0.0