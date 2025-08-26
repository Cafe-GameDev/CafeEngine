# CafeAudioManager Plugin Limitations

Please be aware of the following limitation of the `CafeAudioManager`:

*   **Mono Audio Only:** This AudioManager is exclusively designed for mono audio. It does not currently support 2D or 3D positional audio effects. If your project requires spatial audio, you may need to integrate additional `AudioStreamPlayer2D` or `AudioStreamPlayer3D` nodes and manage their playback separately, or consider extending this plugin's functionality.