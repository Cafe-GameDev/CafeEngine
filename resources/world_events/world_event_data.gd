extends Resource
class_name WorldEventData

enum EventType { WEATHER_CHANGE, ENEMY_INVASION, RESOURCE_SPAWN, SPECIAL_EVENT }

@export var event_name: String = ""
@export var description: String = ""
@export var event_type: EventType = EventType.SPECIAL_EVENT
@export var duration: float = 0.0 # 0.0 for instant, >0 for timed events
@export var effects: Array[Resource] # Array of EffectData applied during the event
@export var trigger_conditions: Array[String] # e.g., "player_in_area_forest", "game_day_10"
@export var associated_enemies: Array[Resource] # Array of EnemyData to spawn
@export var associated_collectibles: Array[Resource] # Array of CollectibleData to spawn