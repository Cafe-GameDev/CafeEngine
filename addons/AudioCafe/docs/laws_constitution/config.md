# Constituição da Configuração

**Status:** Constitucional
**Documento:** `docs/laws_constitution/config.md`

---

### **Artigo I: Propósito e Função**

O `AudioConfig` (`audio_config.tres`) é a **única fonte da verdade** para todas as configurações globais do AudioCafe. Ele serve como o cérebro configurável do plugin, acessível e modificável primariamente através do `AudioPanel`.

### **Artigo II: Propriedades Invioláveis**

As seguintes propriedades constituem o núcleo de configuração do AudioCafe v1.0:

1.  **`sfx_paths` e `music_paths`**: Define os diretórios onde o `AudioManifest` buscará por ativos de áudio.
2.  **`default_*_key`**: O conjunto de chaves padrão que serve como fallback para todos os nós de `Control` da família `SFX*`, sendo a base da automação de áudio de UI.
3.  **`master_volume`, `sfx_volume`, `music_volume`**: Controlam os volumes dos buses de áudio principais.

### **Artigo III: Mecanismo de Atualização**

O recurso `AudioConfig` deve, obrigatoriamente, emitir o sinal `config_changed` sempre que uma de suas propriedades for alterada. Este sinal é o mecanismo que garante a reatividade de todo o sistema às mudanças de configuração.
