# CafeAudioManager Native Audio Library

The `CafeAudioManager` plugin includes a basic set of SFX and music assets for demonstration, testing, and quick prototyping purposes. These assets are located in:

*   `res://addons/CafeAudioManager/assets/sfx/`
*   `res://addons/CafeAudioManager/assets/music/`

You are encouraged to replace these placeholder assets with your own or add new ones. When doing so, ensure that:

1.  Your custom audio files are placed within the `sfx_root_path` and `music_root_path` directories (or their subdirectories) that you have configured for the `CafeAudioManager` node.
2.  You **regenerate the `AudioManifest`** after adding, removing, or renaming any audio files to ensure the plugin can correctly reference them.