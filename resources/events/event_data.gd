extends Resource
class_name EventData

class EventOption extends Resource:
	@export var option_text: String = ""
	@export var effects: Array[Resource] # Array of EffectData (e.g., stat changes, resource gains)
	@export var next_event_id: String = "" # ID of next event, if branching
	@export var unlocks_quests: Array[String] # Array of QuestData IDs

@export var event_id: String = ""
@export var title: String = ""
@export var description: String = ""
@export var image_path: String = ""
@export var trigger_conditions: Array[String] # e.g., "year_is_1444", "player_owns_province_x"
@export var options: Array[EventOption]
@export var cooldown: float = 0.0 # Time before this event can trigger again