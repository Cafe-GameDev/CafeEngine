# CafeAudioManager Plugin Configuration

The `CafeAudioManager` relies on a few key configurations to function correctly.

## 1. AudioManifest Generation

The `AudioManifest` is a `.tres` resource that acts as a lookup table for your audio files. It maps user-friendly audio keys (e.g., "jump_sfx", "background_music_1") to the unique resource IDs (UIDs) that Godot assigns to imported audio files. This is vital for ensuring that audio plays correctly in exported game builds, where direct file paths might not be reliable.

### How to Generate/Update the `AudioManifest`:

1.  **Select the Node:** In your main scene (or any scene where `CafeAudioManager` is present), select the `CafeAudioManager` node in the Scene tree.
2.  **Locate the Script:** In the Godot editor's "File System" panel, navigate to `res://addons/CafeAudioManager/scripts/generate_audio_manifest.gd`.
3.  **Open in Script Editor:** Right-click on `generate_audio_manifest.gd` and select "Open in Script Editor".
4.  **Run the Script:** With the script open, go to `File` -> `Run Script` (or press `F6`).
5.  **Verification:** The `AudioManifest.tres` file will be generated or updated and saved to `res://addons/CafeAudioManager/resources/audio_manifest.tres`. You should see output in the Godot console indicating the manifest generation process.

**Image Point:** An image showing the `generate_audio_manifest.gd` script in the script editor and the "Run Script" option would be very helpful.

*   **Important:** You should re-run this script whenever you add, remove, or rename audio files in your `sfx_root_path` or `music_root_path` directories to ensure the manifest is up-to-date.

## 2. Audio Root Paths

The `CafeAudioManager` automatically discovers audio files within specified root directories. These paths can be configured in the Inspector panel when the `CafeAudioManager` node is selected:

*   **`sfx_root_path`**: This property defines the absolute path to the folder containing all your sound effects.
    *   **Default:** `res://addons/CafeAudioManager/assets/sfx/`
    *   **Example:** If you store your SFX in `res://assets/audio/sfx/`, you would set this property to that path.
*   **`music_root_path`**: This property defines the absolute path to the folder containing all your music tracks.
    *   **Default:** `res://addons/CafeAudioManager/assets/music/`
    *   **Example:** If you store your music in `res://assets/audio/music/`, you would set this property to that path.

**Image Point:** An image showing the Inspector of the `CafeAudioManager` node with the `sfx_root_path` and `music_root_path` fields highlighted would be useful.

### Structure within Root Paths:

The plugin expects audio files to be directly within these root paths or in subdirectories. For example:

```
res://addons/CafeAudioManager/assets/sfx/
├───interface/
│   ├───button_click.ogg
│   └───menu_open.ogg
├───player/
│   ├───jump.ogg
│   └───hit.ogg
```
In this structure, `button_click`, `menu_open`, `jump`, and `hit` would be recognized as SFX keys.