# Lei do Manifesto Extensível e da Geração de Ativos de Playlist

**Status:** Proposta
**Documento:** `docs/leis/manifest.md`

---

### **Preâmbulo**

Para evoluir as capacidades do AudioCafe em alinhamento com o Godot 4.3+ sem invalidar projetos existentes, esta lei estabelece a **extensão** do sistema de manifesto. O objetivo é introduzir um novo e poderoso workflow de geração de ativos `AudioStreamPlaylist` de forma aditiva, garantindo 100% de compatibilidade com a arquitetura do AudioCafe v1.

---

### **Artigo I: Princípio da Compatibilidade e Extensão**

*   **Seção 1.1: Manutenção do `AudioManifest.tres` v1:** Fica estabelecido que a estrutura e o processo de geração do arquivo `res://addons/AudioCafe/resources/audio_manifest.tres` serão integralmente preservados. Ele continuará a mapear chaves de texto para arrays de UIDs de áudio. Esta medida garante que toda a lógica existente que depende deste arquivo (ex: `play_secondary_sound`, scripts de jogo legados) continue funcionando sem qualquer modificação.

*   **Seção 1.2: O Sistema de Ativos de Playlist Aditivo:** Um novo processo de geração será adicionado em paralelo ao processo existente. Para cada chave de áudio encontrada durante o escaneamento, o sistema também irá gerar um recurso `AudioStreamPlaylist` (`.tres`) correspondente. Este processo é puramente aditivo e não interfere com o manifesto v1.

---

### **Artigo II: Geração Programática de `AudioStreamPlaylist`**

*   **Seção 2.1: Estrutura do Recurso `AudioStreamPlaylist`:** Este recurso nativo da Godot contém uma lista de `AudioStream`s e propriedades como `loop` e `shuffle`. Nossa geração automática irá criar e popular estes recursos para espelhar os agrupamentos de chaves do manifesto.

*   **Seção 2.2: Processo de Geração Estendido:** O script `generate_audio_manifest.gd` será modificado para incluir uma segunda fase, a ser executada após a geração do manifesto v1:
    1.  **Fase 1 (Compatibilidade v1):** Escaneia os diretórios e gera/atualiza o `AudioManifest.tres` com chaves e arrays de UIDs, como já faz.
    2.  **Fase 2 (Extensão v2):** Após a Fase 1, o script itera sobre as chaves do `AudioManifest.tres` recém-criado. Para cada chave (ex: `ui_click`):
        *   Cria um novo objeto `AudioStreamPlaylist` em memória.
        *   Para cada UID no array da chave, carrega o `AudioStream` correspondente.
        *   Adiciona cada `AudioStream` carregado à lista de streams da nova playlist.
        *   Define o modo de reprodução padrão como aleatório (`shuffle = true`) e loop (`loop = true`), que são padrões sensatos para a maioria dos casos de uso.
        *   Salva o recurso em um novo diretório com o nome da chave: `res://addons/AudioCafe/resources/generated/playlists/ui_click.tres`.

---

### **Artigo III: Interoperabilidade e "Conversão" de Recursos**

*   **Seção 3.1: Esclarecimento sobre Conversão:** Fica estabelecido, com base em pesquisa técnica, que não existe uma função de "casting" ou conversão direta entre os tipos de `AudioStream` (`Playlist`, `Interactive`, `Synchronized`) no Godot. A "conversão" é um processo de migração de dados.

*   **Seção 3.2: `AudioStreamPlaylist` como Bloco de Construção:** O valor dos `.tres` de playlist gerados é que eles servem como um "agrupamento" de áudio pronto e organizado. Para criar um `AudioStreamInteractive` mais complexo, o desenvolvedor pode inspecionar o `ui_click.tres` gerado, ver os clipes que o compõem e arrastá-los para o editor do `AudioStreamInteractive`, usando a playlist como uma paleta de sons pré-selecionados.

*   **Seção 3.3: Potencial para Ferramentas Futuras:** O `AudioPanel` poderá, no futuro, incluir uma ferramenta auxiliar "Criar Interativo a partir de Playlist" que automatize o processo descrito na Seção 3.2, lendo uma playlist e criando um novo recurso interativo com os mesmos clipes, fortalecendo ainda mais o workflow.

---

### **Artigo IV: Lógica de Acesso e Compatibilidade no `CafeAudioManager`**

*   **Seção 4.1: Acesso de Camada Dupla:** O `CafeAudioManager` será atualizado para suportar ambos os sistemas de forma transparente, garantindo a retrocompatibilidade.
    *   **Diretriz 4.1.1 (Prioridade v2):** Ao receber um pedido como `play_music_requested("level_theme")`, o manager primeiro tentará construir e carregar o caminho para o recurso de playlist correspondente: `res://addons/AudioCafe/resources/generated/playlists/level_theme.tres`. Se este arquivo existir, ele será carregado e atribuído ao player, utilizando o sistema nativo da Godot.
    *   **Diretriz 4.1.2 (Fallback v1):** Se o arquivo `.tres` da v2 não for encontrado, o manager reverterá para a lógica v1: procurará a chave `level_theme` no `AudioManifest.tres` principal e tocará um som aleatório do array de UIDs. Isso garante que projetos antigos ou setups que não queiram usar o novo sistema continuem funcionando sem alterações.

---

### **Conclusão**

Esta lei formaliza um plano de evolução robusto e seguro. Ao estender o sistema de manifesto em vez de substituí-lo, introduzimos um workflow moderno e poderoso que alavanca os recursos nativos da Godot 4.3+, ao mesmo tempo que garantimos estabilidade e compatibilidade total para projetos existentes. Esta abordagem de "melhoria progressiva" permite que os usuários adotem os novos recursos em seu próprio ritmo, sem quebrar seus projetos atuais.
