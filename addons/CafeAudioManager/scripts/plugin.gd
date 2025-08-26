
@tool
extends EditorPlugin

var generate_manifest_button: Button
var generate_manifest_script: EditorScript
var file_system_watcher: FileSystemWatcher
var sfx_root_path: String
var music_root_path: String

func _enter_tree():
    # Load the EditorScript for generating the AudioManifest.
    generate_manifest_script = load("res://addons/CafeAudioManager/scripts/generate_audio_manifest.gd")

    # Get the root paths for SFX and Music from the manifest generation script.
    # We need to instantiate it temporarily to get the export variables.
    if generate_manifest_script:
        var temp_script_instance = generate_manifest_script.new()
        sfx_root_path = temp_script_instance.sfx_root_path
        music_root_path = temp_script_instance.music_root_path
        temp_script_instance.free()

    # Create a button for generating the manifest.
    generate_manifest_button = Button.new()
    generate_manifest_button.text = "Generate Audio Manifest"
    generate_manifest_button.icon = get_editor_interface().get_base_control().get_theme_icon("Reload", "EditorIcons")
    generate_manifest_button.tooltip_text = "Generates the AudioManifest.tres file."
    generate_manifest_button.pressed.connect(_on_generate_manifest_button_pressed)

    # Add the button to the editor's main toolbar.
    add_control_to_container(CONTAINER_TOOLBAR, generate_manifest_button)

    # Setup FileSystemWatcher for audio asset changes.
    file_system_watcher = FileSystemWatcher.new()
    add_child(file_system_watcher)
    file_system_watcher.add_path(sfx_root_path)
    file_system_watcher.add_path(music_root_path)
    file_system_watcher.filters = ["*.ogg", "*.wav"]
    file_system_watcher.recursive = true
    file_system_watcher.changed.connect(_on_file_system_changed)

    print("CafeAudioManager plugin loaded. 'Generate Audio Manifest' button added to toolbar. Audio asset monitoring started.")

func _exit_tree():
    # Clean up when the plugin is unloaded.
    remove_control_from_container(CONTAINER_TOOLBAR, generate_manifest_button)
    generate_manifest_button.queue_free()
    generate_manifest_script = null

    if file_system_watcher:
        file_system_watcher.queue_free()
        file_system_watcher = null

    print("CafeAudioManager plugin unloaded.")

func _on_generate_manifest_button_pressed():
    if generate_manifest_script:
        var script_instance = generate_manifest_script.new()
        script_instance._run()
        script_instance.free()
    else:
        push_error("generate_audio_manifest.gd script not loaded!")

func _on_file_system_changed(path: String):
    # Check if the changed file is an audio file within our monitored paths.
    if path.ends_with(".ogg") or path.ends_with(".wav"):
        get_editor_interface().popup_notification("Audio asset changed! Consider regenerating AudioManifest.")
        print("Detected audio asset change: %s. Suggesting AudioManifest regeneration." % path)
