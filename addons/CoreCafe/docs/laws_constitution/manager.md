# Constituição do Gerenciador (CoreCafe)

**Status:** Constitucional
**Documento:** `addons/CoreCafe/docs/laws_constitution/manager.md`

---

### **Artigo I: Autoload Central**

O CoreCafe **DEVE** prover um Autoload (`CoreManager` ou similar) para gerenciar serviços compartilhados, como um bus de eventos global para a suíte ou o gerenciamento de temas do editor.

### **Artigo II: Padrão Arquitetural**

O CoreCafe estabelece o padrão de "Núcleo + Autoload" que os outros plugins devem seguir, conforme a "Constituição do Gerenciador de Plugin" do CafeEngine.
