extends Resource
class_name AdPlacementData

enum AdType { REWARDED, INTERSTITIAL, BANNER }

@export var placement_id: String = "" # Unique ID for the ad placement
@export var ad_type: AdType = AdType.REWARDED
@export var description: String = ""
@export var rewards: Array[Resource] # Array of CurrencyData or ItemData for rewarded ads
@export var cooldown: float = 0.0 # Time in seconds before another ad can be shown