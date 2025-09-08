extends Resource
class_name ItemAffixData

enum ItemTypeEnum { WEAPON, ARMOR, JEWELRY, ACCESSORY, CUSTOM }

@export var affix_name: String = ""
@export var description: String = ""
@export var effects: Array[Resource] # Array of EffectData
@export var rarity: int = 0 # Corresponds to Rarity enum in ItemData
@export var applies_to_item_type: ItemTypeEnum = ItemTypeEnum.CUSTOM