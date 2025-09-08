extends Resource
class_name GameSettingsData

enum Difficulty { EASY, NORMAL, HARD, VERY_HARD }

@export var master_volume: float = 1.0
@export var music_volume: float = 1.0
@export var sfx_volume: float = 1.0
@export var difficulty: Difficulty = Difficulty.NORMAL
@export var resolution_width: int = 1920
@export var resolution_height: int = 1080
@export var fullscreen: bool = true
@export var language: String = "en"