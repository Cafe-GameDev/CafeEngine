# Biblioteca de Audio Nativa de CafeAudioManager

El plugin `CafeAudioManager` incluye un conjunto básico de recursos de SFX y música para fines de demostración, prueba y prototipado rápido. Estos recursos se encuentran en:

*   `res://addons/CafeAudioManager/assets/sfx/`
*   `res://addons/CafeAudioManager/assets/music/`

Se le anima a reemplazar estos recursos de marcador de posición con los suyos propios o a añadir nuevos. Al hacerlo, asegúrese de que:

1.  Sus archivos de audio personalizados se coloquen dentro de los directorios `sfx_root_path` y `music_root_path` (o sus subdirectorios) que haya configurado para el nodo `CafeAudioManager`.
2.  **Regenere el `AudioManifest`** después de añadir, eliminar o cambiar el nombre de cualquier archivo de audio para asegurarse de que el plugin pueda referenciarlos correctamente.