extends Resource
class_name TypeData

@export var type_name: String = ""
@export var color: Color = Color.WHITE
@export var strengths: Array[String] # Array of TypeData IDs that this type is strong against
@export var weaknesses: Array[String] # Array of TypeData IDs that this type is weak against
@export var immunities: Array[String] # Array of TypeData IDs that this type is immune to