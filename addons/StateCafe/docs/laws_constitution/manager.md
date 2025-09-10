# Constituição do Gerenciador de Estado (StateGlobal)

**Status:** Constitucional
**Documento:** `addons/StateCafe/docs/laws_constitution/manager.md`

---

### **Artigo I: Ponto de Acesso Global**

O `StateGlobal` **DEVE** atuar como o `singleton` (Autoload) para o StateCafe, provendo uma API global para consulta e manipulação de estados de jogo.

### **Artigo II: Lógica do Usuário**

O `StateGlobal` é o local designado para a lógica de estado customizada do usuário, herdando da classe núcleo `StateCafe` que contém a lógica interna do plugin.
