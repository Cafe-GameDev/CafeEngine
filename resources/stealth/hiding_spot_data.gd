extends Resource
class_name HidingSpotData

enum HidingSpotType { BUSH, HAYSTACK, CROWD, CLOSET, SHADOW }

@export var spot_id: String = ""
@export var description: String = ""
@export var type: HidingSpotType = HidingSpotType.BUSH
@export var capacity: int = 1 # How many players/NPCs can hide here