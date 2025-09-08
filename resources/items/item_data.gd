extends Resource
class_name ItemData

enum Rarity { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }

@export var item_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var stackable: bool = true
@export var max_stack_size: int = 1
@export var rarity: Rarity = Rarity.COMMON