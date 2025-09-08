extends Resource
class_name TalentData

enum TalentTier { TIER_1, TIER_2, TIER_3, TIER_4, TIER_5 }

@export var talent_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var tier: TalentTier = TalentTier.TIER_1
@export var effects: Array[Resource] # Array of EffectData
@export var prerequisites: Array[String] # Array of TalentData IDs