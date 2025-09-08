extends Resource
class_name WeaponModData

enum WeaponModSlot { BARREL, SCOPE, MAGAZINE, STOCK, GRIP, CUSTOM }

@export var mod_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var slot_type: WeaponModSlot = WeaponModSlot.CUSTOM
@export var stat_bonuses: Array[Resource] # Array of EffectData
@export var crafting_cost: Array[Resource] # Array of ItemQuantity (nested class from BuildingData)