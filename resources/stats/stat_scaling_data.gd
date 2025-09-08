extends Resource
class_name StatScalingData

enum ScalingType { WEAPON_DAMAGE, SPELL_POWER, HEALING_POWER, DEFENSE_BONUS }
enum PrimaryStat { STRENGTH, DEXTERITY, INTELLIGENCE, CONSTITUTION, LUCK }
enum ScalingGrade { S, A, B, C, D, E }

@export var scaling_type: ScalingType = ScalingType.WEAPON_DAMAGE
@export var primary_stat: PrimaryStat = PrimaryStat.STRENGTH
@export var scaling_grade: ScalingGrade = ScalingGrade.C
@export var scaling_value: float = 1.0 # How much the stat contributes per point