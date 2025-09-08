extends Resource
class_name WaveData

class EnemySpawn extends Resource:
	@export var enemy_data: Resource # Reference to EnemyData
	@export var quantity: int = 1
	@export var spawn_delay: float = 0.0 # Delay before this enemy spawns in the wave

@export var wave_number: int = 0
@export var description: String = ""
@export var enemy_composition: Array[EnemySpawn]
@export var spawn_interval: float = 1.0 # Time between enemy spawns in the wave
@export var rewards_items: Array[Resource] # Array of ItemData
@export var rewards_currency: int = 0