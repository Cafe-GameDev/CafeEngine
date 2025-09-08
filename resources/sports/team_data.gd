extends Resource
class_name TeamData

class StrategyData extends Resource:
	@export var strategy_name: String = ""
	@export var description: String = ""
	@export var offensive_tendency: float = 0.5 # 0.0 to 1.0
	@export var defensive_tendency: float = 0.5 # 0.0 to 1.0

@export var team_name: String = ""
@export var logo_path: String = ""
@export var roster: Array[Resource] # Array of CharacterData or PlayerStatData
@export var strategy_data: StrategyData