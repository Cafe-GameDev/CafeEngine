# Constituição da Integração com o Editor

**Status:** Constitucional
**Documento:** `docs/laws_constitution/editor.md`

---

### **Artigo I: Propósito e Função**

Os scripts na pasta `editor/` são a cola que torna o AudioCafe uma parte integrada da experiência de desenvolvimento no Godot. Sua função é automatizar processos e registrar os componentes do plugin para um uso transparente.

### **Artigo II: Componentes Essenciais**

1.  **`EditorPlugin` (`editor_plugin.gd`):**
    *   **Responsabilidade:** É o orquestrador principal. Deve gerenciar o ciclo de vida do `AudioPanel` e do autoload `CafeAudioManager`, e registrar todos os tipos de nós customizados (`SFX*`, `AudioPosition`, etc.) para que estejam disponíveis no editor.

2.  **`EditorExportPlugin` (`editor_export_plugin.gd`):**
    *   **Responsabilidade:** É o guardião da build. Sua função inviolável é acionar a geração do `AudioManifest` antes da exportação do projeto, garantindo que a versão final do jogo nunca tenha um manifesto desatualizado.
