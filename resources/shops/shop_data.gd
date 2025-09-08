extends Resource
class_name ShopData

class ShopItem extends Resource:
	@export var item_data: Resource # Reference to ItemData (Consumable or NonConsumable)
	@export var price: int = 0
	@export var stock: int = -1 # -1 for infinite stock

@export var shop_name: String = ""
@export var description: String = ""
@export var inventory: Array[ShopItem]
@export var refresh_interval: float = 0.0 # Time in seconds for inventory to refresh (0 for no refresh)