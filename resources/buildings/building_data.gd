extends Resource
class_name BuildingData

class ItemQuantity extends Resource:
	@export var item_data: Resource # Reference to ItemData
	@export var quantity: int = 1

@export var building_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var cost: Array[ItemQuantity]
@export var build_time: float = 0.0
@export var effects: Array[Resource] # Array of EffectData applied when built
@export var produces: Array[ItemQuantity] # Items produced over time