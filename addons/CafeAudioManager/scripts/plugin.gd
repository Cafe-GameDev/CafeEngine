@tool
extends EditorPlugin

const AUTOLOAD_NAME = "CafeAudioManager"
const AUTOLOAD_PATH = "res://addons/CafeAudioManager/scenes/cafe_audio_manager.tscn"

var generate_manifest_button: Button
var generate_manifest_script_instance: EditorScript

func _enter_tree():
	# Add the CafeAudioManager as an Autoload (Singleton)
	add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)
	print("CafeAudioManager Plugin: Autoload '%s' added." % AUTOLOAD_NAME)

	# Load and instantiate the EditorScript for generating the AudioManifest.
	var generate_manifest_script_res = load("res://addons/CafeAudioManager/scripts/generate_audio_manifest.gd")
	if generate_manifest_script_res:
		generate_manifest_script_instance = generate_manifest_script_res.new()
	else:
		push_error("generate_audio_manifest.gd script not found or could not be loaded!")
		return # Exit if the script isn't loaded

	# Create a button for generating the manifest.
	generate_manifest_button = Button.new()
	generate_manifest_button.text = "Generate Audio Manifest"
	generate_manifest_button.icon = get_editor_interface().get_base_control().get_theme_icon("Reload", "EditorIcons")
	generate_manifest_button.tooltip_text = "Generates the AudioManifest.tres file."
	generate_manifest_button.pressed.connect(_on_generate_manifest_button_pressed)

	# Add the button to the editor's main toolbar.
	add_control_to_container(CONTAINER_TOOLBAR, generate_manifest_button)

	print("CafeAudioManager plugin loaded. 'Generate Audio Manifest' button added to toolbar.")

func _exit_tree():
	# Remove the Autoload when the plugin is deactivated
	remove_autoload_singleton(AUTOLOAD_NAME)
	print("CafeAudioManager Plugin: Autoload '%s' removed." % AUTOLOAD_NAME)

	# Clean up when the plugin is unloaded.
	remove_control_from_container(CONTAINER_TOOLBAR, generate_manifest_button)
	generate_manifest_button.queue_free()

	if generate_manifest_script_instance:
		# generate_manifest_script_instance.free() # EditorScript is RefCounted and should not be freed manually
		generate_manifest_script_instance = null

	print("CafeAudioManager plugin unloaded.")

func _on_generate_manifest_button_pressed():
	if generate_manifest_script_instance:
		generate_manifest_script_instance._run()
	else:
		push_error("generate_audio_manifest.gd script instance not available!")
