extends Resource
class_name ChallengeData

@export var challenge_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var objectives: Array[String] # Array of objective descriptions
@export var rewards_items: Array[Resource] # Array of ItemData
@export var rewards_experience: int = 0
@export var rewards_currency: int = 0
@export var prerequisites: Array[String] # Array of ChallengeData IDs or other conditions