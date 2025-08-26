# Visión General de CafeAudioManager

El plugin `CafeAudioManager` está diseñado para ser un sistema de gestión de audio robusto y desacoplado para proyectos de Godot Engine. Reemplaza el sistema de audio predeterminado que a menudo se encuentra en plantillas como "Café Essentials - Godot Brew Kit" y actúa como un EventBus dedicado para todas las comunicaciones relacionadas con el audio. Esto centraliza la lógica de audio, facilitando su gestión en todo el juego.

## Características Clave:

*   **Carga Dinámica de Audio:** El plugin escanea y carga automáticamente archivos de audio desde directorios configurables, categorizándolos en bibliotecas de efectos de sonido (SFX) y música. Esto elimina la necesidad de precargar manualmente cada recurso de audio.
*   **Pool de Reproductores SFX:** Utiliza un pool configurable de instancias de `AudioStreamPlayer` para manejar los efectos de sonido. Esto evita el corte de audio cuando se reproducen múltiples SFX simultáneamente y optimiza el rendimiento al reutilizar los reproductores.
*   **Gestión de Listas de Reproducción de Música:** Proporciona una gestión integral para la música, incluyendo la capacidad de definir listas de reproducción, reproducir pistas aleatoriamente dentro de una categoría y manejar transiciones automáticas o manuales entre canciones.
*   **Control de Volumen Desacoplado:** Ofrece una forma limpia de controlar el volumen de diferentes buses de audio (por ejemplo, Master, Música, SFX) sin dependencias directas, promoviendo una arquitectura modular.
*   **Compatibilidad con Compilaciones Exportadas:** Asegura que su configuración de audio funcione sin problemas en compilaciones de juego exportadas utilizando un `AudioManifest` para referenciar recursos de audio a través de sus IDs únicos (UIDs).

## Limitaciones:

*   **Solo Audio Mono:** Este AudioManager está diseñado exclusivamente para audio mono. Actualmente, no es compatible con efectos de audio posicional 2D o 3D. Si su proyecto requiere audio espacial, es posible que deba integrar nodos `AudioStreamPlayer2D` o `AudioStreamPlayer3D` adicionales y gestionar su reproducción por separado, o considerar extender la funcionalidad de este plugin.