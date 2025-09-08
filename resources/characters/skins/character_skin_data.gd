extends Resource
class_name CharacterSkinData

@export var skin_name: String = ""
@export var description: String = ""
@export var model_path: String = "" # Path to 3D model or 2D scene for the skin
@export var icon_path: String = ""
@export var unlocked_by_achievement: String = "" # AchievementData ID
@export var unlocked_by_challenge: String = "" # ChallengeData ID
@export var cost: int = 0