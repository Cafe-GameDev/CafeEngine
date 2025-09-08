extends Resource
class_name ProgressionData

class LevelUnlock extends Resource:
	@export var level: int = 1
	@export var unlocked_upgrades: Array[Resource] # Array of UpgradeData
	@export var unlocked_skills: Array[Resource] # Array of SkillData

@export var experience_curve: Array[float] # XP needed for each level, index 0 for level 1, etc.
@export var level_unlocks: Array[LevelUnlock]