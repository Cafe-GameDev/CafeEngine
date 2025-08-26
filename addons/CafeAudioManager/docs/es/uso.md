# Uso del Plugin CafeAudioManager

El `CafeAudioManager` opera principalmente a través de señales, funcionando como un EventBus. Esto significa que usted emite señales para solicitar la reproducción de audio o cambios de volumen, y el gestor se encarga de las operaciones de audio reales.

## 1. Señales (EventBus de Audio)

El `CafeAudioManager` emite y escucha señales específicas para gestionar eventos de audio.

### 1.1. Señales Emitidas

Estas señales son emitidas por el `CafeAudioManager` para notificar a otras partes de su juego sobre eventos de audio. Puede conectarse a estas señales desde cualquier script que necesite reaccionar a los cambios de audio.

*   `music_track_changed(music_key: String)`
    *   **Descripción:** Emitida cuando una nueva pista de música comienza a reproducirse.
    *   **Parámetros:**
        *   `music_key`: La clave de cadena de la pista de música que acaba de comenzar.
    *   **Caso de Uso de Ejemplo:** Actualizar un elemento de la interfaz de usuario para mostrar el título de la canción actual.

*   `volume_changed(bus_name: String, linear_volume: float)`
    *   **Descripción:** Emitida cada vez que se altera el volumen de un bus de audio.
    *   **Parámetros:**
        *   `bus_name`: El nombre del bus de audio cuyo volumen cambió (por ejemplo, "Master", "Music", "SFX").
        *   `linear_volume`: El nuevo valor de volumen lineal (0.0 a 1.0).
    *   **Caso de Uso de Ejemplo:** Actualizar un control deslizante de volumen en su menú de opciones.

### 1.2. Señales Escuchadas

Estas señales son escuchadas por el `CafeAudioManager`. Debe emitir estas señales desde la lógica de su juego para solicitar la reproducción de audio o ajustes de volumen.

*   `play_sfx_requested(sfx_key: String, bus: String = "SFX", manager_node: Node = null)`
    *   **Descripción:** Solicita al `CafeAudioManager` que reproduzca un efecto de sonido específico.
    *   **Parámetros:**
        *   `sfx_key`: (String) La clave del SFX a reproducir, tal como se define en su `AudioManifest`.
        *   `bus`: (String, opcional) El nombre del bus de audio para reproducir el SFX (por ejemplo, "SFX", "UI"). Predeterminado: "SFX".
        *   `manager_node`: (Node, opcional) Una referencia a un nodo `CafeAudioPlayer2D` o `CafeAudioPlayer3D` que debe gestionar la reproducción posicional del audio. Si es `null` (predeterminado), el `CafeAudioManager` central gestiona la reproducción no posicional.
    *   **Ejemplo:** `CafeAudioManager.play_sfx_requested.emit("sfx_salto", "SFX", null)` (Reproducido por el AudioManager central)
    *   **Ejemplo (futuro v2.0):** `CafeAudioManager.play_sfx_requested.emit("pasos", "SFX", $Player/CafeAudioPlayer2D)` (Reproducido por el CafeAudioPlayer2D del Jugador)

*   `play_music_requested(music_key: String, manager_node: Node = null)`
    *   **Descripción:** Solicita al `CafeAudioManager` que reproduzca una pista de música específica o inicie una lista de reproducción.
    *   **Parámetros:**
        *   `music_key`: (String) La clave de la pista de música o lista de reproducción a reproducir, tal como se define en su `AudioManifest`.
        *   `manager_node`: (Node, opcional) Una referencia a un nodo `CafeAudioPlayer2D` o `CafeAudioPlayer3D` que debe gestionar la reproducción posicional del audio. Si es `null` (predeterminado), el `CafeAudioManager` central gestiona la reproducción no posicional.
    *   **Ejemplo:** `CafeAudioManager.play_music_requested.emit("tema_nivel_1", null)` (Reproducido por el AudioManager central)

*   `volume_changed(bus_name: String, linear_volume: float)`
    *   **Descripción:** El `CafeAudioManager` escucha su propia señal `volume_changed` para aplicar ajustes de volumen al bus de audio especificado. Esto permite una forma consistente de cambiar el volumen desde cualquier parte de su aplicación.
    *   **Parámetros:** Los mismos que la señal `volume_changed` emitida.
    *   **Ejemplo:** `CafeAudioManager.volume_changed.emit("Musica", 0.75)`

## 2. Reproducción de Efectos de Sonido (SFX)

Para reproducir un SFX, simplemente emita la señal `play_sfx_requested` con la `sfx_key` apropiada y, opcionalmente, el nombre del `bus`.

```gdscript
# Ejemplo: Reproducir un efecto de sonido de salto en el bus "SFX"
CafeAudioManager.play_sfx_requested.emit("sfx_salto", "SFX")

# Ejemplo: Reproducir un efecto de sonido de clic de UI en el bus "UI" (si tiene uno configurado)
CafeAudioManager.play_sfx_requested.emit("clic_boton", "UI")
```

## 3. Reproducción de Música

Para reproducir una pista de música o iniciar una lista de reproducción, emita la señal `play_music_requested` con la `music_key` correspondiente.

```gdscript
# Ejemplo: Reproducir una pista de música de fondo específica
CafeAudioManager.play_music_requested.emit("tema_nivel_1")

# Ejemplo: Iniciar una lista de reproducción de música (si está configurada en su AudioManifest)
CafeAudioManager.play_music_requested.emit("lista_reproduccion_menu_principal")
```

## 4. Control de Volumen

Para cambiar el volumen de un bus de audio, emita la señal `volume_changed`.

```gdscript
# Ejemplo: Establecer el volumen Maestro al 50%
CafeAudioManager.volume_changed.emit("Master", 0.5)

# Ejemplo: Establecer el volumen de la Música al 75%
CafeAudioManager.volume_changed.emit("Musica", 0.75)

# Ejemplo: Silenciar SFX (establecer volumen al 0%)
CafeAudioManager.volume_changed.emit("SFX", 0.0)
```