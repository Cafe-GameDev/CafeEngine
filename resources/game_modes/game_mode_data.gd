extends Resource
class_name GameModeData

enum GameModeType { PAYLOAD, CONTROL, ASSAULT, ESCORT, DEATHMATCH, CUSTOM }

@export var mode_name: String = ""
@export var description: String = ""
@export var type: GameModeType = GameModeType.CUSTOM
@export var rules_text: String = ""
@export var objectives: Array[String]
@export var time_limit: float = 0.0 # 0.0 for no time limit
@export var score_limit: int = 0 # 0 for no score limit