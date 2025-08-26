# CafeAudioManager Plugin Usage

The `CafeAudioManager` operates primarily through signals, functioning as an EventBus. This means you emit signals to request audio playback or volume changes, and the manager handles the actual audio operations.

## 1. Signals (Audio EventBus)

The `CafeAudioManager` emits and listens to specific signals to manage audio events.

### 1.1. Emitted Signals

These signals are emitted by the `CafeAudioManager` to notify other parts of your game about audio events. You can connect to these signals from any script that needs to react to audio changes.

*   `music_track_changed(music_key: String)`
    *   **Description:** Emitted when a new music track begins playing.
    *   **Parameters:**
        *   `music_key`: The string key of the music track that just started.
    *   **Example Use Case:** Updating a UI element to show the current song title.

*   `volume_changed(bus_name: String, linear_volume: float)`
    *   **Description:** Emitted whenever the volume of an audio bus is altered.
    *   **Parameters:**
        *   `bus_name`: The name of the audio bus whose volume changed (e.g., "Master", "Music", "SFX").
        *   `linear_volume`: The new linear volume value (0.0 to 1.0).
    *   **Example Use Case:** Updating a volume slider in your options menu.

### 1.2. Listened Signals

These signals are listened to by the `CafeAudioManager`. You should emit these signals from your game logic to request audio playback or volume adjustments.

*   `play_sfx_requested(sfx_key: String, bus: String = "SFX", manager_node: Node = null)`
    *   **Description:** Requests the `CafeAudioManager` to play a specific sound effect.
    *   **Parameters:**
        *   `sfx_key`: (String) The key of the SFX to be played, as defined in your `AudioManifest`.
        *   `bus`: (String, optional) The name of the audio bus to play the SFX on (e.g., "SFX", "UI"). Defaults to "SFX".
        *   `manager_node`: (Node, optional) A reference to a `CafeAudioPlayer2D` or `CafeAudioPlayer3D` node that should manage the positional playback of the audio. If `null` (default), the central `CafeAudioManager` handles non-positional playback.
    *   **Example:** `CafeAudioManager.play_sfx_requested.emit("jump_sfx", "SFX", null)` (Played by the central AudioManager)
    *   **Example (future v2.0):** `CafeAudioManager.play_sfx_requested.emit("footsteps", "SFX", $Player/CafeAudioPlayer2D)` (Played by the Player's CafeAudioPlayer2D)

*   `play_music_requested(music_key: String, manager_node: Node = null)`
    *   **Description:** Requests the `CafeAudioManager` to play a specific music track or start a playlist.
    *   **Parameters:**
        *   `music_key`: (String) The key of the music track or playlist to be played, as defined in your `AudioManifest`.
        *   `manager_node`: (Node, optional) A reference to a `CafeAudioPlayer2D` or `CafeAudioPlayer3D` node that should manage the positional playback of the audio. If `null` (default), the central `CafeAudioManager` handles non-positional playback.
    *   **Example:** `CafeAudioManager.play_music_requested.emit("level_1_theme", null)` (Played by the central AudioManager)

*   `volume_changed(bus_name: String, linear_volume: float)`
    *   **Description:** The `CafeAudioManager` listens to its own `volume_changed` signal to apply volume adjustments to the specified audio bus. This allows for a consistent way to change volume from any part of your application.
    *   **Parameters:** Same as the emitted `volume_changed` signal.
    *   **Example:** `CafeAudioManager.volume_changed.emit("Music", 0.75)`

## 2. Playing Sound Effects (SFX)

To play an SFX, simply emit the `play_sfx_requested` signal with the appropriate `sfx_key` and optionally the `bus` name.

```gdscript
# Example: Play a jump sound effect on the "SFX" bus
CafeAudioManager.play_sfx_requested.emit("jump_sfx", "SFX")

# Example: Play a UI click sound effect on the "UI" bus (if you have one configured)
CafeAudioManager.play_sfx_requested.emit("button_click", "UI")
```

## 3. Playing Music

To play a music track or start a playlist, emit the `play_music_requested` signal with the corresponding `music_key`.

```gdscript
# Example: Play a specific background music track
CafeAudioManager.play_music_requested.emit("level_1_theme")

# Example: Start a music playlist (if configured in your AudioManifest)
CafeAudioManager.play_music_requested.emit("main_menu_playlist")
```

## 4. Volume Control

To change the volume of an audio bus, emit the `volume_changed` signal.

```gdscript
# Example: Set the Master volume to 50%
CafeAudioManager.volume_changed.emit("Master", 0.5)

# Example: Set the Music volume to 75%
CafeAudioManager.volume_changed.emit("Music", 0.75)

# Example: Mute SFX (set volume to 0%)
CafeAudioManager.volume_changed.emit("SFX", 0.0)
```