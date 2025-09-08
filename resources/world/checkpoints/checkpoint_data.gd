extends Resource
class_name CheckpointData

@export var checkpoint_id: String = ""
@export var location: Vector3 = Vector3.ZERO
@export var rest_effects: Array[Resource] # Array of EffectData applied on rest (e.g., heal, remove debuffs)
@export var respawn_enemies: bool = true
@export var unlocks_shortcuts: Array[String] # Array of TraversalPointData IDs that become active