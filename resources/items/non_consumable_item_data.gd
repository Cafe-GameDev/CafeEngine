extends ItemData
class_name NonConsumableItemData

enum EquippedSlot { NONE, HEAD, CHEST, LEGS, WEAPON, ACCESSORY }

@export var is_unique: bool = false
@export var can_be_equipped: bool = false
@export var equipped_slot: EquippedSlot = EquippedSlot.NONE
@export var stat_bonuses: Array[Resource] # Array of EffectData or similar