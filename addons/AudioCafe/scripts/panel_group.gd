@tool
extends VBoxContainer
@onready var audio_manifest: Button = $AudioManifest

var generate_manifest_script_instance: EditorScript = "res://addons/AudioCafe/scripts/generate_audio_manifest.gd"
func _on_audio_manifest_pressed() -> void:
	if generate_manifest_script_instance:
		generate_manifest_script_instance._run()
	else:
		push_error("generate_audio_manifest.gd script instance not available!")
