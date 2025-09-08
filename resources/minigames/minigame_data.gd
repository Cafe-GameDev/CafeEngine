extends Resource
class_name MiniGameData

enum MiniGameType { GAMBLING, SPORTS, PUZZLE, RACING, CUSTOM }

@export var minigame_name: String = ""
@export var description: String = ""
@export var type: MiniGameType = MiniGameType.CUSTOM
@export var entry_cost: int = 0
@export var rewards: Array[Resource] # Array of ItemData
@export var scene_path: String = "" # Path to the minigame scene
@export var rules_text: String = ""