# Constituição do Estilo de Código do CafeEngine

**Status:** Constitucional
**Documento:** `docs/laws_constitution/styleguide.md`

---

### **Preâmbulo**

Um estilo de código consistente é fundamental para a legibilidade, manutenibilidade e colaboração em toda a suíte CafeEngine. Esta lei estabelece as diretrizes de estilo de código para todo o desenvolvimento em GDScript.

### **Artigo I: Princípios Gerais**

1.  **Clareza e Legibilidade:** O código deve ser fácil de ler e entender.
2.  **Consistência:** Manter o estilo consistente em todo o projeto.
3.  **Simplicidade:** Preferir soluções simples e diretas.

### **Artigo II: Convenções de Nomenclatura**

1.  **Classes/Arquivos:** `PascalCase` (ex: `PlayerController.gd`, `AudioCafe.gd`).
2.  **Funções/Métodos:** `snake_case` (ex: `_ready`, `process_input`).
3.  **Variáveis:** `snake_case` (ex: `player_speed`, `current_health`).
4.  **Constantes:** `SCREAMING_SNAKE_CASE` (ex: `MAX_SPEED`).
5.  **Sinais:** `past_tense_verb` (ex: `health_depleted`, `save_completed`).

### **Artigo III: Formatação**

1.  **Indentação:** Usar **4 espaços**. Não usar tabs.
2.  **Quebra de Linha:** Limitar linhas a aproximadamente 100-120 caracteres.

### **Artigo IV: Tipagem**

O uso de **tipagem estática** para variáveis, argumentos de função e retornos de função é **fortemente recomendado** e deve ser a norma em todo o código do CafeEngine para melhorar a clareza, a detecção de erros e o autocompletar do editor.
