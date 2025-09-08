extends Resource
class_name TimeOfDayData

enum TimeOfDayPhase { DAWN, DAY, DUSK, NIGHT }

@export var time_name: String = ""
@export var description: String = ""
@export var phase: TimeOfDayPhase = TimeOfDayPhase.DAY
@export var light_color: Color = Color.WHITE
@export var light_intensity: float = 1.0
@export var ambient_sound_path: String = ""
@export var gameplay_modifiers: Array[Resource] # Array of EffectData for player/NPCs