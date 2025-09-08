extends Resource
class_name WeaponPerkData

enum WeaponTypeEnum { ASSAULT_RIFLE, SMG, SNIPER, PISTOL, SHOTGUN, MELEE, CUSTOM }

@export var perk_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var effects: Array[Resource] # Array of EffectData
@export var applies_to_weapon_type: WeaponTypeEnum = WeaponTypeEnum.CUSTOM