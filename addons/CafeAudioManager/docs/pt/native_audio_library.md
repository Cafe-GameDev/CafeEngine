# Biblioteca de Áudio Nativa do CafeAudioManager

O plugin `CafeAudioManager` inclui um conjunto básico de assets de SFX e música para fins de demonstração, teste e prototipagem rápida. Esses assets estão localizados em:

*   `res://addons/CafeAudioManager/assets/sfx/`
*   `res://addons/CafeAudioManager/assets/music/`

Você é encorajado a substituir esses assets de placeholder pelos seus próprios ou adicionar novos. Ao fazer isso, certifique-se de que:

1.  Seus arquivos de áudio personalizados sejam colocados dentro dos diretórios `sfx_root_path` e `music_root_path` (ou seus subdiretórios) que você configurou para o nó `CafeAudioManager`.
2.  Você **regenere o `AudioManifest`** depois de adicionar, remover ou renomear quaisquer arquivos de áudio para garantir que o plugin possa referenciá-los corretamente.