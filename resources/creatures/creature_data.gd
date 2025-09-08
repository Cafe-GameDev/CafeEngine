extends Resource
class_name CreatureData

class EvolutionData extends Resource:
	@export var evolves_to_creature: Resource # Reference to another CreatureData
	@export var evolution_level: int = 0
	@export var evolution_item: Resource # Reference to ItemData, if item-based evolution

@export var creature_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var base_stats: Resource # Reference to CharacterData
@export var abilities: Array[Resource] # Array of MoveData
@export var types: Array[Resource] # Array of TypeData
@export var evolution_data: EvolutionData # Evolution details, if applicable