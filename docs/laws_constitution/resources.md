# Constituição dos Recursos de Dados

**Status:** Constitucional
**Documento:** `docs/laws_constitution/resources.md`

---

### **Preâmbulo**

Os recursos (`Resource`) são a espinha dorsal da persistência de dados e da configuração no Godot. Esta lei estabelece os princípios que governam o uso de recursos de dados dentro do ecossistema CafeEngine.

### **Artigo I: Princípio da Configuração via Recurso**

Todo plugin **DEVE** usar um recurso customizado (ex: `AudioConfig.tres`, `SaveConfig.tres`) como a fonte da verdade para suas configurações editáveis pelo usuário.

### **Artigo II: Princípio da Abstração de Dados via Recurso**

Plugins que gerenciam conjuntos de dados complexos (como `DataCafe` ou `SaveCafe`) **DEVEM** prover uma classe base de `Resource` (ex: `DataResource`, `SaveResource`) da qual os tipos de dados específicos do usuário devem herdar. Isso garante uma API consistente e facilita o gerenciamento de dados.

### **Artigo III: Princípio da Geração Programática**

Recursos que servem como um catálogo ou manifesto de ativos (como o `AudioManifest`) **DEVEM** ser gerados e gerenciados programaticamente pelo plugin. Eles não devem ser editados manualmente pelo usuário.
