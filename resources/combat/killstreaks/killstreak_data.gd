extends Resource
class_name KillstreakData

@export var killstreak_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var kills_required: int = 0
@export var effects: Array[Resource] # Array of EffectData or custom actions
@export var duration: float = 0.0 # 0.0 for instant, >0 for timed