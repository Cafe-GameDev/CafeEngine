extends Resource
class_name LoreData

@export var lore_id: String = ""
@export var title: String = ""
@export var text_content: String = ""
@export var associated_item: Resource # Reference to ItemData
@export var associated_npc: Resource # Reference to NPCData
@export var location: Vector3 = Vector3.ZERO # World location where lore can be found