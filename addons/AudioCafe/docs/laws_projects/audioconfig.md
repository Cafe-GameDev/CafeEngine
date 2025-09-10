# Lei da Configuração Central (AudioConfig v2.0)

**Status:** Proposta
**Documento:** `docs/leis/audioconfig.md`

---

### **Preâmbulo**

Enquanto componentes como o `AudioPanel` e o `AudioPosition` passam por uma reformulação funcional, o `AudioConfig` permanece como a espinha dorsal das configurações do plugin. Esta lei visa refinar e focar suas responsabilidades, removendo propriedades obsoletas e adicionando novos controles que suportem a arquitetura v2.0, solidificando seu papel como o único ponto da verdade para as configurações do AudioCafe.

---

### **Artigo I: Propriedades a Serem Mantidas**

As seguintes propriedades são fundamentais para o workflow do AudioCafe e serão mantidas integralmente:

*   **Seção 1.1: Caminhos de Busca (`sfx_paths`, `music_paths`):** Continuam sendo a base para o processo de geração do manifesto.
*   **Seção 1.2: Chaves de UI Padrão (`default_*_key`):** Este conjunto de propriedades (`default_click_key`, `default_hover_key`, etc.) é um dos maiores diferenciais do plugin, fornecendo o sistema de fallback para os `SFX* Nodes`. Sua manutenção é de alta prioridade.
*   **Seção 1.3: Volumes Globais (`master_volume`, `sfx_volume`, `music_volume`):** Permanecem como o método principal para o controle de volume global através do `AudioPanel`.
*   **Seção 1.4: Estado do Painel (`is_panel_expanded`):** Será mantida como uma funcionalidade de qualidade de vida para a experiência do usuário no editor.

---

### **Artigo II: Propriedades a Serem Removidas (Limpeza)**

Para evitar confusão e simplificar a arquitetura, certas propriedades que não se alinham com a separação de responsabilidades da v2.0 serão removidas.

*   **Seção 2.1: Remoção de `music_data` e `sfx_data`:** As propriedades `@export var music_data: Dictionary` e `@export var sfx_data: Dictionary` serão **removidas** do script `audio_config.gd`. A responsabilidade de armazenar os dados do manifesto pertence exclusivamente ao recurso `AudioManifest.tres`. Manter cópias ou referências desses dados no `AudioConfig` cria ambiguidade e potenciais bugs de sincronização.

---

### **Artigo III: Novas Propriedades de Configuração para a v2.0**

Para suportar o novo sistema de geração de playlists, novas opções de configuração serão adicionadas.

*   **Seção 3.1: Caminho de Destino para Ativos Gerados:**
    *   **Diretriz 3.1.1:** Será adicionada a propriedade `@export var generated_assets_path: String = "res://addons/AudioCafe/resources/generated/"`. Isso dará ao usuário a flexibilidade de alterar onde as playlists e outros futuros ativos gerados serão salvos.

*   **Seção 3.2: Configurações Padrão para Playlists Geradas:** O processo de geração de `AudioStreamPlaylist` usará os seguintes novos valores como padrão, que podem ser ajustados pelo usuário no `AudioPanel`.
    *   **Diretriz 3.2.1:** Adicionar `@export var default_playlist_loop: bool = true`.
    *   **Diretriz 3.2.2:** Adicionar `@export var default_playlist_shuffle: bool = true`.
    *   **Diretriz 3.2.3:** Adicionar `@export_range(0.0, 5.0, 0.1) var default_playlist_fade_time: float = 0.3`.

---

### **Artigo IV: Mecanismos de Integração**

*   **Seção 4.1: Manutenção do Sinal `config_changed`:** O sinal `config_changed` e a função `_save_and_emit_changed()` que o dispara serão mantidos. Este mecanismo é vital para que outras partes do plugin (como o `AudioPanel` e o `CafeAudioManager`) possam reagir em tempo real às alterações de configuração.

---

### **Conclusão**

O `AudioConfig` v2.0 será um recurso mais enxuto, focado e poderoso. Ao remover responsabilidades que não lhe pertencem (armazenamento de dados do manifesto) e adicionar configurações granulares para o novo sistema de geração de ativos, seu papel como o "arquivo de configurações" central do plugin se torna mais claro e robusto, contribuindo para a manutenibilidade e a clareza de toda a arquitetura do AudioCafe.
