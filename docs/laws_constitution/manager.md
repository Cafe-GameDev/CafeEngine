# Constituição do Gerenciador de Plugin (Autoload)

**Status:** Constitucional
**Documento:** `docs/laws_constitution/manager.md`

---

### **Artigo I: Princípio do Ponto de Acesso Global**

Todo plugin da suíte CafeEngine **DEVE** prover um único `singleton` (Autoload) que atue como seu ponto central de orquestração e sua API pública para outros scripts.

### **Artigo II: Princípio da Nomenclatura Descritiva**

O nome do script do Autoload **DEVE** ser descritivo e único dentro do ecossistema para evitar conflitos. Por exemplo, `SaveSystem` para o `SaveCafe`, `StateGlobal` para o `StateCafe`.

### **Artigo III: Princípio da Separação de Responsabilidades**

O Autoload serve como a API pública e o ponto de lógica para o usuário. A lógica interna, complexa e vital do plugin **DEVE**, preferencialmente, residir em uma classe núcleo separada (ex: `SaveCafe.gd`, `StateCafe.gd`), da qual o Autoload pode herdar ou da qual pode ser uma instância. Isso separa a interface pública da implementação interna.
