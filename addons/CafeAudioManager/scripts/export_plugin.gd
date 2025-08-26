@tool
extends EditorExportPlugin

func _export_begin(features, is_debug, path, flags):
    print("Running pre-export script for AudioManifest generation...")
    var generate_manifest_script = load("res://addons/CafeAudioManager/scripts/generate_audio_manifest.gd")
    if generate_manifest_script:
        var script_instance = generate_manifest_script.new()
        script_instance._run()
        script_instance.free()
        print("AudioManifest generation completed during export.")
    else:
        push_error("generate_audio_manifest.gd not found for export hook!")

func _export_file(path, type, features):
    # This method is called for each file being exported.
    # We don't need to do anything here for the manifest generation.
    pass
