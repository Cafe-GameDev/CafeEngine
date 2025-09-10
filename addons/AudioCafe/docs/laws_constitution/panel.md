# Constituição do Painel do Editor

**Status:** Constitucional
**Documento:** `docs/laws_constitution/panel.md`

---

### **Artigo I: Propósito e Função**

O `AudioPanel` é a **interface primária e visual** entre o usuário e o sistema AudioCafe. Sua função é fornecer um ponto de acesso centralizado e intuitivo para todas as configurações e ações principais do plugin, diretamente no editor Godot.

### **Artigo II: Funcionalidades Essenciais**

O `AudioPanel` deve, no mínimo, prover as seguintes funcionalidades:

1.  **Gerenciamento de Configurações:** Expor de forma clara todas as propriedades do recurso `AudioConfig`, permitindo sua fácil modificação.
2.  **Ação de Geração do Manifesto:** Conter o botão "Generate Audio Manifest", que serve como o gatilho manual para o processo de catalogação de áudio.
3.  **Visualização de Ativos:** Exibir as chaves de áudio (`music` e `sfx`) que foram registradas no `AudioManifest`, dando ao usuário um feedback imediato do que está disponível para uso no projeto.
