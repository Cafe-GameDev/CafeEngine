# Constituição do Painel do Editor

**Status:** Constitucional
**Documento:** `docs/laws_constitution/panel.md`

---

### **Artigo I: Princípio da Interface Centralizada**

Todo plugin da suíte CafeEngine **DEVE** fornecer um painel de editor (`[PluginName]Panel.tscn`) que se integre ao `CafePanel` principal, criando uma experiência de usuário unificada e um ponto de acesso central para as ferramentas do CafeEngine.

### **Artigo II: Princípio da Funcionalidade Mínima**

Todo painel de plugin **DEVE** incluir, no mínimo:
1.  Um botão ou link para acessar a **documentação** específica daquele plugin.
2.  Um botão para abrir rapidamente o script do **Autoload** correspondente, facilitando a customização pelo usuário.
3.  Controles visuais para todas as configurações expostas pelo recurso de configuração (`.tres`) do plugin.

### **Artigo III: Princípio da Ação Direta**

O Painel deve prover botões e controles para acionar as principais ações do plugin (como a geração de manifestos, migração de dados, etc.) de forma direta e com feedback visual claro para o usuário.
