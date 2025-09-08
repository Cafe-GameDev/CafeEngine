extends Resource
class_name EventPassData

class PassTier extends Resource:
	@export var tier_number: int = 1
	@export var required_xp: int = 0
	@export var free_rewards: Array[Resource] # Array of CurrencyData or ItemData
	@export var premium_rewards: Array[Resource] # Array of CurrencyData or ItemData

@export var pass_id: String = ""
@export var pass_name: String = ""
@export var description: String = ""
@export var start_date: String = "" # YYYY-MM-DD
@export var end_date: String = "" # YYYY-MM-DD
@export var tiers: Array[PassTier]