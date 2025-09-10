# Constituição da Integração com o Editor

**Status:** Constitucional
**Documento:** `docs/laws_constitution/editor.md`

---

### **Artigo I: Princípio da Integração Transparente**

A integração de cada plugin com o editor Godot deve ser transparente e intuitiva, fazendo com que seus componentes se comportem como extensões nativas da engine.

### **Artigo II: Princípio do Registro de Componentes**

Cada plugin é responsável por registrar todos os seus nós e recursos customizados através de um `EditorPlugin`, garantindo que eles estejam disponíveis no diálogo "Add Node" e no `Inspector` para instanciação e configuração pelo usuário.

### **Artigo III: Princípio do Ciclo de Vida Gerenciado**

Cada plugin **DEVE** gerenciar seu próprio ciclo de vida no editor. Isso inclui adicionar seu `Autoload` ao `ProjectSettings` quando ativado (`_enter_tree`) e removê-lo de forma limpa quando desativado (`_exit_tree`).
