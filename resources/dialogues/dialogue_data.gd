extends Resource
class_name DialogueData

class DialogueChoice extends Resource:
	@export var choice_text: String = ""
	@export var next_dialogue_id: String = "" # ID of the next dialogue to jump to
	@export var required_condition: String = "" # e.g., "has_item_sword", "quest_completed_123"

@export var dialogue_id: String = ""
@export var character_name: String = ""
@export var dialogue_lines: Array[String]
@export var choices: Array[DialogueChoice] # Array of DialogueChoice resources
@export var next_dialogue_id: String = "" # ID of the next dialogue if no choices are present or chosen