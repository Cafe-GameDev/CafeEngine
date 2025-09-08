extends Resource
class_name CovenantData

class CovenantRankData extends Resource:
	@export var rank_name: String = ""
	@export var required_reputation: int = 0
	@export var rewards: Array[Resource] # Array of ItemData or SkillData

@export var covenant_name: String = ""
@export var description: String = ""
@export var leader_npc: Resource # Reference to NPCData
@export var ranks: Array[CovenantRankData]