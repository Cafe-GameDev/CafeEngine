extends Resource
class_name WeatherData

enum WeatherCondition { CLEAR, RAIN, SNOW, FOG, STORM }

@export var weather_name: String = ""
@export var description: String = ""
@export var condition: WeatherCondition = WeatherCondition.CLEAR
@export var visual_effects_scene_path: String = ""
@export var gameplay_effects: Array[Resource] # Array of EffectData for player/NPCs
@export var spawn_rate_multiplier: float = 1.0 # Multiplier for enemy/resource spawn rates