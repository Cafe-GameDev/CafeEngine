extends Resource
class_name NPCScheduleData

class ScheduleEntry extends Resource:
	@export var start_time: float = 0.0 # Time in hours (e.g., 8.0 for 8:00 AM)
	@export var end_time: float = 0.0
	@export var activity: String = ""
	@export var location: Vector3 = Vector3.ZERO

@export var schedule_name: String = ""
@export var description: String = ""
@export var daily_routines: Array[ScheduleEntry]
@export var home_location: Vector3 = Vector3.ZERO