# Constituição do Painel Central (CorePanel)

**Status:** Constitucional
**Documento:** `addons/CoreCafe/docs/laws_constitution/panel.md`

---

### **Artigo I: O `CafePanel`**

O `CorePanel` (a implementação do `CafePanel`) é a responsabilidade do CoreCafe. Ele **DEVE** ser implementado como um `TabContainer` para permitir que outros plugins adicionem seus próprios painéis como abas.

### **Artigo II: API de Registro**

O `CorePanel` **DEVE** prover um método claro e acessível para que os `EditorPlugin`s de outros plugins possam se registrar e adicionar seus painéis a ele.
