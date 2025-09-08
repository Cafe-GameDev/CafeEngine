extends Resource
class_name MoveData

enum MoveCategory { PHYSICAL, SPECIAL, STATUS }

@export var move_name: String = ""
@export var description: String = ""
@export var power: float = 0.0
@export var accuracy: float = 100.0
@export var pp: int = 0 # Power Points / Uses
@export var move_type: Resource # Reference to TypeData
@export var category: MoveCategory = MoveCategory.PHYSICAL
@export var effects: Array[Resource] # Array of EffectData