extends Resource
class_name TouchControlData

enum ControlType { JOYSTICK, BUTTON, SWIPE, CUSTOM }

class TouchControlElement extends Resource:
	@export var element_id: String = ""
	@export var control_type: ControlType = ControlType.BUTTON
	@export var position: Vector2 = Vector2.ZERO
	@export var size: Vector2 = Vector2(100, 100)
	@export var texture_path: String = ""
	@export var action_name: String = "" # Input action name

@export var layout_name: String = ""
@export var description: String = ""
@export var elements: Array[TouchControlElement]