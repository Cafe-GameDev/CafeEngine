extends Resource
class_name LeaderboardData

enum LeaderboardType { SCORE, TIME, KILLS, CUSTOM }

@export var leaderboard_id: String = ""
@export var leaderboard_name: String = ""
@export var description: String = ""
@export var type: LeaderboardType = LeaderboardType.SCORE
@export var sort_order_ascending: bool = false # True for lower is better, False for higher is better
@export var max_entries: int = 100