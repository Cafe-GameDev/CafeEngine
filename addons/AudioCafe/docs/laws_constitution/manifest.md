# Constituição do Manifesto

**Status:** Constitucional
**Documento:** `docs/laws_constitution/manifest.md`

---

### **Artigo I: Propósito e Função**

O `AudioManifest` (`AudioManifest.tres`) é o **catálogo central de ativos de áudio** do projeto. Sua função sagrada é desacoplar a lógica do jogo do sistema de arquivos, mapeando chaves de texto amigáveis para os identificadores de recursos internos e imutáveis do Godot (UIDs).

### **Artigo II: Estrutura de Dados**

A estrutura do `AudioManifest` é inviolável e consiste em dois dicionários:

1.  **`music_data`**: Mapeia chaves de categorias de música para um `PackedStringArray` de UIDs de áudio.
2.  **`sfx_data`**: Mapeia chaves de categorias de efeitos sonoros para um `PackedStringArray` de UIDs de áudio.

### **Artigo III: Geração de Chaves**

A geração de chaves a partir da estrutura de diretórios é um pilar do fluxo de trabalho do AudioCafe. A regra é imutável: o caminho do subdiretório, relativo ao `path` base definido no `AudioConfig`, torna-se a chave, com as barras (`/`) sendo substituídas por underscores (`_`).
