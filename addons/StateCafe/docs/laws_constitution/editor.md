# Constituição da Integração com o Editor (StateCafe)

**Status:** Constitucional
**Documento:** `addons/StateCafe/docs/laws_constitution/editor.md`

---

### **Artigo I: Registro de Tipos**

O `EditorPlugin` do StateCafe é responsável por registrar todos os seus nós customizados (`StateCharacterBody2D/3D`, `StateZone2D/3D`, etc.) para que apareçam no diálogo "Add Node".

### **Artigo II: Ciclo de Vida**

O plugin **DEVE** gerenciar o ciclo de vida do seu Autoload (`StateGlobal`), adicionando-o e removendo-o dos `ProjectSettings` de forma limpa.
