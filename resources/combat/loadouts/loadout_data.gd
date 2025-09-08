extends Resource
class_name LoadoutData

@export var loadout_name: String = ""
@export var primary_weapon: Resource # Reference to WeaponData
@export var secondary_weapon: Resource # Reference to WeaponData
@export var tactical_gadget: Resource # Reference to GadgetData
@export var lethal_gadget: Resource # Reference to GadgetData
@export var perks: Array[Resource] # Array of PerkData