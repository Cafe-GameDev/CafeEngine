# CafeAudioManager Plugin Installation

To integrate `CafeAudioManager` into your Godot project, follow these detailed steps:

## 1. Add the Plugin Folder

Copy the entire `CafeAudioManager` folder into the `addons/` directory of your Godot project. If the `addons/` folder does not exist, create it in your project's root directory.

*   **Expected Structure:** Your project structure should look like: `your_project_root/addons/CafeAudioManager/...`

## 2. Activate the Plugin

1.  Open your Godot project in the editor.
2.  Go to `Project` -> `Project Settings...`.
3.  Navegate to the `Plugins` tab.
4.  Locate `CafeAudioManager` in the list and ensure its status is set to `Active`.

## 3. Configure as Autoload (Singleton)

1.  In `Project Settings...`, go to the `Autoload` tab.
2.  Click the `Add` button (folder icon) to browse for a path.
3.  Navegate to `res://addons/CafeAudioManager/scenes/cafe_audio_manager.tscn` and select it.
4.  In the `Node Name` field, enter `CafeAudioManager` (or your preferred singleton name).
5.  Ensure `Enable` is checked.
6.  Click `Add`. This makes the `CafeAudioManager` accessible globally from any script.

**Image Point:** An image here showing the `Project Settings > Autoload` window with `CafeAudioManager` added and enabled would be very helpful.

## 4. Generate AudioManifest

This is a crucial step for both development and exported builds.

*   Follow the detailed instructions in the [AudioManifest Generation](../configuration.md#audiomanifest-generation) section in the Configuration documentation.

## 5. Refactor Audio Calls (Migration)

If you are migrating from an existing audio system, you will need to update your code:

*   Replace any direct calls to an old `AudioManager` or audio signals from a `GlobalEvents` singleton with the appropriate `CafeAudioManager` signal emissions.
*   **Example:** Instead of `GlobalEvents.emit_signal("play_sfx", "jump")`, you would use `CafeAudioManager.play_sfx_requested.emit("jump", "SFX")`.