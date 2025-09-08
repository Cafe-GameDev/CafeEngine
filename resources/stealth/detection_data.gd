extends Resource
class_name DetectionData

@export var vision_angle: float = 120.0 # Degrees
@export var vision_range: float = 10.0 # Units
@export var sound_detection_radius: float = 5.0 # Units
@export var alert_time: float = 3.0 # Time before full alert
@export var detection_speed: float = 1.0 # Multiplier for how fast detection fills