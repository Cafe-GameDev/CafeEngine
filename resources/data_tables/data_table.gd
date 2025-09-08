extends Resource
class_name DataTable

@export var entry_type: String = "Resource" # Expected class_name of entries (e.g., "ItemData", "EnemyData")
@export var entries: Array[Resource]