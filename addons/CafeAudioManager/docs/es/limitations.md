# Limitaciones del Plugin CafeAudioManager

Tenga en cuenta la siguiente limitación del `CafeAudioManager`:

*   **Solo Audio Mono:** Este AudioManager está diseñado exclusivamente para audio mono. Actualmente, no es compatible con efectos de audio posicional 2D o 3D. Si su proyecto requiere audio espacial, es posible que deba integrar nodos `AudioStreamPlayer2D` o `AudioStreamPlayer3D` adicionales y gestionar su reproducción por separado, o considerar extender la funcionalidad de este plugin.