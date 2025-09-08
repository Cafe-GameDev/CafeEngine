extends Resource
class_name CurrencyData

@export var currency_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var is_persistent: bool = true # Does it carry over between runs/sessions?
@export var is_collectible: bool = true # Can it be picked up in the world?