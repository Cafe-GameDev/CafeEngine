# Constituição da Configuração do Plugin

**Status:** Constitucional
**Documento:** `docs/laws_constitution/config.md`

---

### **Artigo I: Princípio da Centralização**

Todo e qualquer plugin da suíte CafeEngine **DEVE** prover um único recurso (`Resource`, terminando em `.tres`) que sirva como a **única fonte da verdade** para todas as suas configurações globais e editáveis pelo usuário.

### **Artigo II: Princípio da Acessibilidade via Painel**

As configurações globais de um plugin, como caminhos de busca, volumes, e comportamentos padrão, **DEVEM** ser expostas de forma clara e acessível através da sua interface de usuário dedicada no editor, o `[PluginName]Panel`.

### **Artigo III: Princípio da Reatividade**

O sistema de configuração de cada plugin **DEVE** ser reativo. Qualquer alteração no seu recurso de configuração principal **DEVE** disparar um sinal (`config_changed` ou similar) que permita que outros componentes do ecossistema se atualizem em tempo real, sem a necessidade de reiniciar o editor ou o jogo.
