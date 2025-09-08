extends Resource
class_name BoonData

enum GodAffinity { ZEUS, POSEIDON, ATHENA, ARTEMIS, ARES, DIONYSUS, DEMETER, HERMES, APHRODITE, CHAOS, CUSTOM }

@export var boon_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var god_affinity: GodAffinity = GodAffinity.CUSTOM
@export var rarity: int = 0 # Corresponds to Rarity enum in ItemData
@export var effects: Array[Resource] # Array of EffectData
@export var prerequisites: Array[String] # Array of BoonData IDs