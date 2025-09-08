extends Resource
class_name WeaponUpgradeHadesData

@export var upgrade_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var applies_to_weapon: Resource # Reference to WeaponData
@export var effects: Array[Resource] # Array of EffectData
@export var rarity: int = 0 # Corresponds to Rarity enum in ItemData