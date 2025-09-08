extends Resource
class_name CollectibleData

enum CollectibleType { CURRENCY, LORE, HEALTH_UPGRADE, ENERGY_UPGRADE, KEY_ITEM, MISC }

@export var collectible_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var value: float = 0.0 # e.g., amount of currency, health restored
@export var collectible_type: CollectibleType = CollectibleType.MISC