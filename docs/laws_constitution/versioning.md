# Constituição do Versionamento

**Status:** Constitucional
**Documento:** `docs/laws_constitution/versioning.md`

---

### **Artigo I: Adoção do Versionamento Semântico (SemVer)**

Toda a suíte CafeEngine e cada um de seus plugins individualmente adotam e seguirão estritamente o padrão de Versionamento Semântico 2.0.0. O formato da versão será `MAJOR.MINOR.PATCH`.

### **Artigo II: Definição das Versões**

1.  **`PATCH`:** Correções de bugs retrocompatíveis.
2.  **`MINOR`:** Adição de novas funcionalidades retrocompatíveis.
3.  **`MAJOR`:** Qualquer alteração que quebre a compatibilidade com a versão anterior.

### **Artigo III: Inviolabilidade**

Nenhuma alteração que quebre a compatibilidade será introduzida em uma versão `MINOR` ou `PATCH` de um plugin. Esta regra é inviolável e serve para garantir a confiança e a estabilidade para os usuários da suíte CafeEngine.

### **Artigo IV: Sincronia de Versões**

O pacote completo do CafeEngine terá sua própria versão, que será determinada pela mudança mais significativa em qualquer um dos seus plugins constituintes.
