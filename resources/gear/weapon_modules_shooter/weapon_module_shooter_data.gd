extends Resource
class_name WeaponModuleShooterData

enum ShooterModuleSlot { BARREL, MAGAZINE, STOCK, SIGHT, GRIP, CUSTOM }

@export var module_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var slot_type: ShooterModuleSlot = ShooterModuleSlot.CUSTOM
@export var stat_bonuses: Array[Resource] # Array of EffectData
@export var bullet_pattern: Resource # Reference to BulletPatternData
@export var cost: Array[Resource] # Array of ItemQuantity (nested class from BuildingData)
@export var prerequisites: Array[String] # Array of WeaponModuleShooterData IDs