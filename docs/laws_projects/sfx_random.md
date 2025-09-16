# Projeto de Lei: Refatoração da Geração de Recursos de Áudio

**Status:** Proposta
**Documento:** `docs/laws_projects/sfx_random.md`

---

### **Preâmbulo**

Atualmente, o plugin AudioCafe gera tanto os recursos de música quanto os de efeitos sonoros (SFX) como `AudioStreamPlaylist`. Embora funcional, esta abordagem não aproveita as capacidades específicas de cada tipo de áudio oferecidas pelo Godot Engine. Músicas frequentemente se beneficiam de uma reprodução sequencial ou aleatória de faixas completas, enquanto efeitos sonoros se beneficiam da aleatoriedade simples e da variação de pitch/volume, características do `AudioStreamRandomizer`.

Este Projeto de Lei propõe refatorar o processo de geração do manifesto de áudio para utilizar `AudioStreamPlaylist` para músicas e `AudioStreamRandomizer` para SFX. Esta mudança visa otimizar o uso dos recursos nativos do Godot, melhorar a semântica dos ativos de áudio e preparar o terreno para futuras funcionalidades específicas de cada tipo de stream.

### **Artigo I: Separação de Tipos de Recurso de Áudio**

1.  **Músicas (`music_data`):** Todos os arquivos de áudio categorizados como música (`music_paths` no `AudioConfig`) serão processados e salvos como instâncias de `AudioStreamPlaylist`.
2.  **Efeitos Sonoros (`sfx_data`):** Todos os arquivos de áudio categorizados como efeitos sonoros (`sfx_paths` no `AudioConfig`) serão processados e salvos como instâncias de `AudioStreamRandomizer`.

### **Artigo II: Geração de Recursos Específicos**

1.  **Para `AudioStreamPlaylist` (Músicas):**
    *   A lógica de coleta de streams por `final_key` permanecerá a mesma.
    *   Para cada `final_key` de música, um novo `AudioStreamPlaylist` será criado (ou carregado se já existir).
    *   Os `AudioStream`s coletados para essa `final_key` serão adicionados ao `AudioStreamPlaylist`.
    *   O `AudioStreamPlaylist` será salvo em um arquivo `.tres` no diretório `res://addons/AudioCafe/dist/playlist/` (referenciado pela constante `PLAYLIST_DIST_SAVE_PATH`).
2.  **Para `AudioStreamRandomizer` (SFX):**
    *   A lógica de coleta de streams por `final_key` permanecerá a mesma.
    *   Para cada `final_key` de SFX, um novo `AudioStreamRandomizer` será criado (ou carregado se já existir).
    *   Os `AudioStream`s coletados para essa `final_key` serão adicionados ao `AudioStreamRandomizer` como streams com pesos iguais (o peso padrão será 1.0 para todos os streams adicionados).
    *   O `AudioStreamRandomizer` será salvo em um arquivo `.tres` no diretório `res://addons/AudioCafe/dist/random/` (referenciado pela constante `RANDOM_DIST_SAVE_PATH`).

### **Artigo III: Atualização do `AudioManifest`**

1.  O recurso `AudioManifest.tres` continuará sendo a fonte central de mapeamento de chaves para caminhos de recursos.
2.  O dicionário `music_data` do `AudioManifest` armazenará o caminho para os arquivos `.tres` dos `AudioStreamPlaylist` gerados.
3.  O dicionário `sfx_data` do `AudioManifest` armazenará o caminho para os arquivos `.tres` dos `AudioStreamRandomizer` gerados.

### **Artigo IV: Impacto nos Componentes do Plugin**

1.  **`CafeAudioManager`:**
    *   A função `_on_play_sfx_requested` precisará ser atualizada para esperar um `AudioStreamRandomizer` como `stream` do `AudioStreamPlayer`.
    *   A função `_on_play_music_requested` continuará esperando um `AudioStreamPlaylist`.
2.  **`SFX*` Nodes (Nós de UI):**
    *   Os nós de UI que reproduzem SFX (ex: `SFXButton`, `SFXSlider`) precisarão garantir que o `AudioStreamPlayer` subjacente seja configurado corretamente para reproduzir um `AudioStreamRandomizer`. Isso pode envolver a simples atribuição do recurso ao `stream` do player, pois o `AudioStreamPlayer` é compatível com ambos os tipos.
3.  **`AudioPosition`:**
    *   A função `set_state` e `play_secondary_sound` precisarão ser atualizadas para lidar com `AudioStreamRandomizer` para SFX.

### **Conclusão**

Esta refatoração alinha o AudioCafe com as melhores práticas de gerenciamento de áudio no Godot Engine, utilizando os recursos nativos de forma mais semântica e eficiente. Ao separar músicas e SFX em tipos de recursos apropriados, melhoramos a clareza do projeto, otimizamos o desempenho e abrimos caminho para futuras funcionalidades específicas de cada tipo de áudio, como a configuração de variação de pitch/volume diretamente no `AudioStreamRandomizer` para SFX.
