# Documentação dos Scripts do Editor AudioCafe

Este documento serve como um ponto central de documentação para os scripts relacionados ao editor dentro do plugin AudioCafe. Ele explica o propósito e a funcionalidade de cada script de editor criado para aprimorar a experiência do editor Godot para os usuários do AudioCafe.

---

## Visão Geral dos Scripts de Integração do Editor

### 1. `audio_cafe_inspector_plugin.gd` (Estende `EditorInspectorPlugin`)

*   **Propósito:** Este plugin personaliza como as propriedades de recursos relacionados ao AudioCafe (como `AudioConfig`), nós (`CafeAudioManager`) e nós SFX personalizados (por exemplo, `SFXButton`, `AudioPosition2D/3D`) são exibidos no painel Inspetor do Godot.
*   **Funcionalidade:**
    *   Fornece UI personalizada para `music_data` e `sfx_data` em `AudioConfig`, orientando os usuários a gerenciá-los através do painel do plugin.
    *   Personaliza a exibição de `state_sfx_map` nos nós `AudioPosition2D/3D`.
    *   Adiciona rótulos informativos para propriedades de chave SFX em nós `Control`, indicando que estão vinculados ao Audio Manifest.
*   **Contribuição:** Cria uma experiência de edição mais intuitiva e integrada, fornecendo UI sensível ao contexto no Inspetor.

### 2. `audio_cafe_editor_script.gd` (Estende `EditorScript`)

*   **Propósito:** Este script fornece funcionalidades gerais de tempo de edição que podem ser acionadas manualmente a partir do menu Script do editor Godot ou através de ferramentas de editor personalizadas.
*   **Funcionalidade:**
    *   Inclui um método `_run()` que, quando executado, aciona a geração do Audio Manifest chamando a função `generate_manifest` de `generate_audio_manifest.gd`.
*   **Contribuição:** Oferece uma maneira conveniente para os desenvolvedores realizarem tarefas comuns relacionadas ao AudioCafe diretamente no editor.

### 3. `audio_cafe_asset_management.gd` (Estende `EditorResourcePreviewGenerator`)

*   **Propósito:** Este plugin aprimora a experiência de gerenciamento de ativos para arquivos de áudio dentro do painel Sistema de Arquivos do editor Godot.
*   **Funcionalidade:**
    *   Gera pré-visualizações visuais personalizadas para arquivos de áudio (`.ogg`, `.wav`, `.mp3`) no painel Sistema de Arquivos. Atualmente, ele exibe um quadrado colorido simples, mas foi projetado para ser estendido para visualização de forma de onda.
*   **Contribuição:** Melhora a descoberta de ativos e fornece feedback visual imediato para recursos de áudio.

### 4. `audio_cafe_file_system_plugin.gd` (Estende `EditorFileSystemPlugin`)

*   **Propósito:** Este plugin estende a funcionalidade do painel Sistema de Arquivos do editor Godot, adicionando ações de menu de contexto personalizadas para arquivos de áudio.
*   **Funcionalidade:**
    *   Adiciona as opções "Reproduzir Áudio", "Adicionar ao Manifest SFX" e "Adicionar ao Manifest de Música" ao menu de contexto com o botão direito do mouse em arquivos de áudio.
    *   Fornece lógica de espaço reservado para reproduzir áudio e adicionar arquivos ao Audio Manifest (requer implementação adicional para integrar totalmente com o recurso de manifesto).
*   **Contribuição:** Simplifica tarefas comuns de gerenciamento de ativos de áudio diretamente do painel Sistema de Arquivos.

### 5. `audio_cafe_import_plugin.gd` (Estende `EditorImportPlugin`)

*   **Propósito:** Este plugin permite que a lógica de importação personalizada seja aplicada a arquivos de áudio quando eles são importados para o projeto Godot.
*   **Funcionalidade:**
    *   Define opções de importação personalizadas, como atribuir automaticamente um barramento de áudio padrão (SFX/Música com base em heurística de caminho) e uma opção para adicionar o áudio ao Audio Manifest na importação.
    *   Fornece uma estrutura para pré-processamento de ativos de áudio durante a importação.
*   **Contribuição:** Automatiza e personaliza o fluxo de trabalho de importação para ativos de áudio, garantindo consistência e reduzindo a configuração manual.

### 6. `audio_cafe_export_plugin.gd` (Estende `EditorExportPlugin`)

*   **Propósito:** Este plugin se integra ao processo de exportação de projetos do Godot, permitindo que modificações e otimizações sejam aplicadas ao jogo exportado.
*   **Funcionalidade:**
    *   Fornece ganchos para ações no início e no fim do processo de exportação, e para cada arquivo sendo exportado.
    *   Pode ser estendido para filtrar áudio não utilizado, recodificar áudio para plataformas específicas ou garantir que o Audio Manifest seja corretamente incluído e otimizado na compilação final.
*   **Contribuição:** Garante que os ativos de áudio sejam corretamente preparados e otimizados para diferentes alvos de exportação, melhorando o desempenho do jogo e o tamanho da compilação.
