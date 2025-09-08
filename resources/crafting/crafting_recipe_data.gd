extends Resource
class_name CraftingRecipeData

class CraftingIngredient extends Resource:
	@export var item_data: Resource # Reference to ItemData
	@export var quantity: int = 1

@export var recipe_name: String = ""
@export var description: String = ""
@export var ingredients: Array[CraftingIngredient]
@export var result_item: Resource # Reference to ItemData
@export var result_quantity: int = 1
@export var crafting_time: float = 0.0