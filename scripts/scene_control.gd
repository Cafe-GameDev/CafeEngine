class_name SceneControl extends Control

func _ready() -> void:
	CafeAudioManager.request_audio_start.emit()
