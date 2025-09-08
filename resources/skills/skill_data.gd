extends Resource
class_name SkillData

enum SkillType { ACTIVE, PASSIVE, TOGGLE }
enum TargetType { SELF, SINGLE_ENEMY, MULTIPLE_ENEMIES, SINGLE_ALLY, MULTIPLE_ALLIES, AREA, PROJECTILE }

@export var skill_name: String = ""
@export var description: String = ""
@export var icon_path: String = "" # Path to skill icon texture
@export var skill_type: SkillType = SkillType.ACTIVE
@export var target_type: TargetType = TargetType.SINGLE_ENEMY

@export var mana_cost: float = 0.0
@export var stamina_cost: float = 0.0
@export var cooldown: float = 0.0
@export var cast_time: float = 0.0 # Time to cast the skill

@export var range: float = 0.0 # Range of the skill (e.g., for ranged attacks or area effects)
@export var area_of_effect_radius: float = 0.0 # For AREA target type

@export var effects: Array[Resource] # Array of EffectData resources applied by this skill

@export var sound_effect_path: String = ""
@export var visual_effect_path: String = ""

@export var min_level_required: int = 1
@export var strength_requirement: int = 0
@export var dexterity_requirement: int = 0
@export var intelligence_requirement: int = 0
