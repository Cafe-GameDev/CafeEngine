extends Resource
class_name GraphicsPresetData

@export var preset_name: String = ""
@export var description: String = ""
@export var texture_quality: int = 2 # 0: Low, 1: Medium, 2: High
@export var shadow_quality: int = 2
@export var anti_aliasing: int = 2
@export var post_processing_effects: bool = true
@export var resolution_scale: float = 1.0