extends Resource
class_name WeaponAttachmentData

enum AttachmentSlot { OPTIC, MUZZLE, UNDERBARREL, MAGAZINE, STOCK, GRIP, CUSTOM }

@export var attachment_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var slot_type: AttachmentSlot = AttachmentSlot.CUSTOM
@export var stat_bonuses: Array[Resource] # Array of EffectData
@export var cost: int = 0
@export var prerequisites: Array[String] # Array of other WeaponAttachmentData IDs