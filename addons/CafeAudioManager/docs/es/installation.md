# Instalación del Plugin CafeAudioManager

Para integrar `CafeAudioManager` en su proyecto de Godot, siga estos pasos detallados:

## 1. Añadir la Carpeta del Plugin

Copie la carpeta completa `CafeAudioManager` en el directorio `addons/` de su proyecto de Godot. Si la carpeta `addons/` no existe, créela en el directorio raíz de su proyecto.

*   **Estructura Esperada:** La estructura de su proyecto debería verse así: `su_proyecto_raiz/addons/CafeAudioManager/...`

## 2. Activar el Plugin

1.  Abra su proyecto de Godot en el editor.
2.  Vaya a `Proyecto` -> `Configuración del Proyecto...`.
3.  Navegue a la pestaña `Plugins`.
4.  Localice `CafeAudioManager` en la lista y asegúrese de que su estado esté configurado como `Activo`.

## 3. Configurar como Autoload (Singleton)

1.  En `Configuración del Proyecto...`, vaya a la pestaña `Autoload`.
2.  Haga clic en el botón `Añadir` (icono de carpeta) para buscar una ruta.
3.  Navegue a `res://addons/CafeAudioManager/scenes/cafe_audio_manager.tscn` y selecciónelo.
4.  En el campo `Nombre del Nodo`, ingrese `CafeAudioManager` (o el nombre de singleton de su preferencia).
5.  Asegúrese de que `Habilitar` esté marcado.
6.  Haga clic en `Añadir`. Esto hace que `CafeAudioManager` sea accesible globalmente desde cualquier script.

**Punto para Imagem:** Una imagen aquí mostrando la ventana de `Configuración del Proyecto > Autoload` con `CafeAudioManager` añadido y habilitado sería muy útil.

## 4. Generar AudioManifest

Este es un paso crucial tanto para el desarrollo como para las compilaciones exportadas.

*   Siga las instrucciones detalladas en la sección [Generación del AudioManifest](../configuration.md#generacion-del-audiomanifest) en la documentación de Configuración.

## 5. Refactorizar Llamadas de Audio (Migración)

Si está migrando de un sistema de audio existente, deberá actualizar su código:

*   Reemplace cualquier llamada directa a un `AudioManager` antiguo o señales de audio de un singleton `GlobalEvents` con las emisiones de señal apropiadas de `CafeAudioManager`.
*   **Ejemplo:** En lugar de `GlobalEvents.emit_signal("play_sfx", "jump")`, usaría `CafeAudioManager.play_sfx_requested.emit("jump", "SFX")`.