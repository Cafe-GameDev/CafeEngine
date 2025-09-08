extends Resource
class_name WeaponData

enum WeaponType { MELEE, RANGED, MAGIC, SUPPORT }
enum Rarity { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }

@export var weapon_name: String = "None"
@export var description: String = ""
@export var rarity: Rarity = Rarity.COMMON
@export var weapon_type: WeaponType = WeaponType.MELEE
@export var attack_animation_name: String = ""
@export var damage: float = 0.0
@export var is_ranged: bool = false
@export var projectile_scene: String = ""
@export var sheathe_animation_name: String = ""
@export var idle_animation_name: String = ""
@export var run_animation_name: String = ""

@export var attack_range: float = 0.0
@export var attack_cooldown: float = 0.0
@export var mana_cost: float = 0.0
@export var stamina_cost: float = 0.0
@export var sound_effect_path: String = ""
@export var visual_effect_path: String = ""

@export var crit_chance: float = 0.0
@export var crit_multiplier: float = 1.5
@export var attack_speed_multiplier: float = 1.0

@export var strength_scaling: float = 0.0
@export var dexterity_scaling: float = 0.0
@export var intelligence_scaling: float = 0.0

@export var min_strength: int = 0
@export var min_dexterity: int = 0
@export var min_intelligence: int = 0

@export var max_durability: float = 0.0
@export var current_durability: float = 0.0

@export var on_hit_effects: Array[Resource] # Array[EffectData]
@export var on_equip_effects: Array[Resource] # Array[EffectData]
