# CafeAudioManager Overview

The `CafeAudioManager` plugin is designed to be a robust and decoupled audio management system for Godot Engine projects. It replaces the default audio system often found in templates like "Café Essentials - Godot Brew Kit" and acts as a dedicated EventBus for all audio-related communications. This centralizes audio logic, making it easier to manage throughout your game.

## Key Features:

*   **Dynamic Audio Loading:** The plugin automatically scans and loads audio files from configurable directories, categorizing them into sound effects (SFX) and music libraries. This eliminates the need for manual preloading of every audio asset.
*   **SFX Player Pooling:** It utilizes a configurable pool of `AudioStreamPlayer` instances to handle sound effects. This prevents audio cutting when multiple SFX are played simultaneously and optimizes performance by reusing players.
*   **Music Playlist Management:** Provides comprehensive management for music, including the ability to define playlists, play tracks randomly within a category and handle automatic or manual transitions between songs.
*   **Decoupled Volume Control:** Offers a clean way to control the volume of different audio buses (e.g., Master, Music, SFX) without direct dependencies, promoting a modular architecture.
*   **Export Compatibility:** Ensures that your audio setup works seamlessly in exported builds by using an `AudioManifest` to reference audio resources via their unique IDs (UIDs).

## Limitations:

*   **Mono Audio Only:** This AudioManager is exclusively designed for mono audio. It does not currently support 2D or 3D positional audio effects. If your project requires spatial audio, you may need to integrate additional `AudioStreamPlayer2D` or `AudioStreamPlayer3D` nodes and manage their playback separately, or consider extending this plugin's functionality.