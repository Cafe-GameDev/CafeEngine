# Constituição da Garantia de Qualidade (QA)

**Status:** Constitucional
**Documento:** `docs/laws_constitution/qa.md`

---

### **Preâmbulo**

A estabilidade e a confiabilidade são pilares da qualidade de software. Esta lei estabelece os requisitos mínimos de teste e garantia de qualidade para todo o desenvolvimento na suíte CafeEngine.

### **Artigo I: Requisito de Teste**

Nenhuma nova funcionalidade ou refatoração significativa em qualquer plugin será considerada completa sem um **Plano de Teste** correspondente.

### **Artigo II: Formato do Plano de Teste**

Um plano de teste pode assumir a forma de uma cena de teste automatizado (preferencial), uma cena de teste manual, ou um procedimento de teste documentado.

### **Artigo III: Teste de Regressão**

Antes de qualquer novo lançamento (`PATCH`, `MINOR` ou `MAJOR`) de um plugin, um esforço de teste de regressão deve ser realizado para garantir que as novas alterações não quebraram funcionalidades existentes, executando todos os planos de teste previamente estabelecidos para aquele plugin.
