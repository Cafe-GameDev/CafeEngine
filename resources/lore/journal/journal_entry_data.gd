extends Resource
class_name JournalEntryData

enum JournalEntryType { ENEMY, LOCATION, CHARACTER, LORE, ITEM, CUSTOM }

@export var entry_id: String = ""
@export var title: String = ""
@export var content: String = ""
@export var type: JournalEntryType = JournalEntryType.CUSTOM
@export var associated_enemy: Resource # Reference to EnemyData
@export var associated_location: Resource # Reference to RoomData
@export var associated_character: Resource # Reference to NPCData or CharacterData
@export var associated_item: Resource # Reference to ItemData
@export var unlocked_by_enemy_defeat: String = "" # EnemyData ID
@export var unlocked_by_collectible: String = "" # CollectibleData ID