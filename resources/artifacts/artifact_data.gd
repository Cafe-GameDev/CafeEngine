extends Resource
class_name ArtifactData

@export var artifact_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var effects: Array[Resource] # Array of EffectData
@export var rarity: int = 0 # Corresponds to Rarity enum in ItemData
@export var unlocked_by_challenge: String = "" # ChallengeData ID