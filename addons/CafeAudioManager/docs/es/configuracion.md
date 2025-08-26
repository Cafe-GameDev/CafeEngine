# Configuración del Plugin CafeAudioManager

El `CafeAudioManager` depende de algunas configuraciones clave para funcionar correctamente.

## 1. Generación del AudioManifest

El `AudioManifest` es un recurso `.tres` que actúa como una tabla de búsqueda para sus archivos de audio. Mapea claves de audio fáciles de usar (por ejemplo, "sfx_salto", "musica_fondo_1") a los IDs de recurso únicos (UIDs) que Godot asigna a los archivos de audio importados. Esto es vital para garantizar que el audio se reproduzca correctamente en compilaciones de juego exportadas, donde las rutas de archivo directas podrían no ser confiables.

### Cómo Generar/Actualizar el `AudioManifest`:

1.  **Seleccione el Nodo:** En su escena principal (o en cualquier escena donde `CafeAudioManager` esté presente), seleccione el nodo `CafeAudioManager` en el árbol de Escena.
2.  **Localice el Script:** En el panel "Sistema de Archivos" del editor de Godot, navegue a `res://addons/CafeAudioManager/scripts/generate_audio_manifest.gd`.
3.  **Abrir en Editor de Script:** Haga clic derecho en `generate_audio_manifest.gd` y seleccione "Abrir en Editor de Script".
4.  **Ejecutar el Script:** Con el script abierto, vaya a `Archivo` -> `Ejecutar Script` (o presione `F6`).
5.  **Verificación:** El archivo `AudioManifest.tres` se generará o actualizará y se guardará en `res://addons/CafeAudioManager/resources/audio_manifest.tres`. Debería ver una salida en la consola de Godot indicando el proceso de generación del manifiesto.

**Punto para Imagem:** Una imagen mostrando el script `generate_audio_manifest.gd` en el editor de script y la opción "Ejecutar Script" sería muy útil.

*   **Importante:** Debe volver a ejecutar este script cada vez que añada, elimine o cambie el nombre de archivos de audio en sus directorios `sfx_root_path` o `music_root_path` para asegurarse de que el manifiesto esté actualizado.

## 2. Rutas Raíz de Audio

El `CafeAudioManager` descubre automáticamente los archivos de audio dentro de los directorios raíz especificados. Estas rutas se pueden configurar en el panel Inspector cuando se selecciona el nodo `CafeAudioManager`:

*   **`sfx_root_path`**: Esta propiedad define la ruta absoluta a la carpeta que contiene todos sus efectos de sonido.
    *   **Predeterminado:** `res://addons/CafeAudioManager/assets/sfx/`
    *   **Ejemplo:** Si almacena sus SFX en `res://assets/audio/sfx/`, configuraría esta propiedad a esa ruta.
*   **`music_root_path`**: Esta propiedad define la ruta absoluta a la carpeta que contiene todas sus pistas de música.
    *   **Predeterminado:** `res://addons/CafeAudioManager/assets/music/`
    *   **Ejemplo:** Si almacena su música en `res://assets/audio/music/`, configuraría esta propiedad a esa ruta.

**Punto para Imagem:** Una imagen mostrando el Inspector del nodo `CafeAudioManager` con los campos `sfx_root_path` y `music_root_path` resaltados sería útil.

### Estructura dentro de las Rutas Raíz:

El plugin espera que los archivos de audio estén directamente dentro de estas rutas raíz o en subdirectorios. Por ejemplo:

```
res://addons/CafeAudioManager/assets/sfx/
├───interface/
│   ├───button_click.ogg
│   └───menu_open.ogg
├───player/
│   ├───jump.ogg
│   └───hit.ogg
```
En esta estructura, `button_click`, `menu_open`, `jump` y `hit` serían reconocidos como claves SFX.