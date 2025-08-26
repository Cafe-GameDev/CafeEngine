# Limitações do Plugin CafeAudioManager

Por favor, esteja ciente da seguinte limitação do `CafeAudioManager`:

*   **Apenas Áudio Mono:** Este AudioManager é projetado exclusivamente para áudio mono. Atualmente, não oferece suporte para efeitos de áudio posicional 2D ou 3D. Se o seu projeto exigir áudio espacial, você pode precisar integrar nós `AudioStreamPlayer2D` ou `AudioStreamPlayer3D` adicionais e gerenciar sua reprodução separadamente, ou considerar estender a funcionalidade deste plugin.