extends Resource
class_name DailyRewardData

class RewardEntry extends Resource:
	@export var day_number: int = 1
	@export var currency_rewards: Array[Resource] # Array of CurrencyData and quantity
	@export var item_rewards: Array[Resource] # Array of ItemData and quantity

@export var reward_name: String = ""
@export var description: String = ""
@export var rewards_by_day: Array[RewardEntry]