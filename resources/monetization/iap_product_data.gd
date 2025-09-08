extends Resource
class_name IAPProductData

enum ProductType { CONSUMABLE, NON_CONSUMABLE, SUBSCRIPTION }

@export var product_id: String = "" # Unique ID for the IAP product
@export var product_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var product_type: ProductType = ProductType.CONSUMABLE
@export var price_usd: float = 0.99
@export var currency_rewards: Array[Resource] # Array of CurrencyData and quantity
@export var item_rewards: Array[Resource] # Array of ItemData and quantity