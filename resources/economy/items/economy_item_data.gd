extends Resource
class_name EconomyItemData

enum EconomyItemType { WEAPON, GRENADE, EQUIPMENT, ARMOR, CUSTOM }

@export var item_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var buy_price: int = 0
@export var sell_price: int = 0
@export var item_type: EconomyItemType = EconomyItemType.CUSTOM
@export var is_consumable: bool = false