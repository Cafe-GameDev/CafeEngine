# CafeEngine - Plugin Design Document (PDD) Geral

**Versão do Documento:** 1.1
**Data:** 2025-10-13
**Autor:** Café GameDev

---

## 1. Visão Geral e Filosofia da Suíte CafeEngine

### 1.1. Conceito

A **CafeEngine** é uma suíte de plugins para Godot Engine 4.x, projetada para fornecer um conjunto robusto e modular de ferramentas para o desenvolvimento de jogos. Cada plugin aborda um domínio específico (ex: áudio, estados, dados, eventos), mas todos compartilham uma filosofia central: **modularidade, reutilização e integração nativa com o editor Godot.**

### 1.2. Filosofia Central: Programação Orientada a Resources (ROP)

A pedra angular da CafeEngine é a **Programação Orientada a Resources (ROP)**. O sistema de `Resource` da Godot é tratado como um mecanismo de **entidades ativas**, não apenas contêineres de dados.

#### Princípios Fundamentais

*   **Lógica Encapsulada:** Cada `Resource` pode conter comportamento e dados, tornando-se autocontido e reusável.
*   **Design Orientado a Dados:** Separa-se o *o quê* (dados e regras) do *como* (Nodes que executam o comportamento).
*   **Reatividade:** Resources emitem sinais e reagem a eventos, criando sistemas dinâmicos e desacoplados.
*   **Fluxo Godot-Native:** Toda a edição ocorre via Inspector e FileSystem, maximizando a integração com o editor.

### 1.3. Política de Versão e Compatibilidade

*   **Versão Alvo:** Godot 4.5+
*   **Compatibilidade:** Mantida com versões futuras da série 4.x.
*   **Retrocompatibilidade:** Nenhum suporte a versões anteriores a 4.5, garantindo código moderno e limpo.

---

## 2. Arquitetura Central da Suíte

A CafeEngine adota uma arquitetura modular e extensível. Cada plugin segue o mesmo padrão estrutural e de integração ao editor.

### 2.1. Componentes Comuns

Cada plugin da CafeEngine é construído com um conjunto de componentes comuns para garantir consistência e interoperabilidade.

*   **`[PluginName]Manager` (Autoload Singleton):** Nodo global que gerencia recursos e operações em runtime.
*   **`[PluginName]Config` (Resource):** Armazena preferências e configurações persistentes do plugin. Emite `config_changed`.
*   **`[Domain]Data` (Resource Base):** Classe base abstrata para dados e comportamentos do domínio.
*   **`EditorPlugin` (`editor_plugin.gd`):** Integra o plugin ao editor, registra tipos customizados e adiciona o painel.
*   **`[PluginName]Panel` (UI):** Interface gráfica do plugin dentro do editor.

### 2.2. O `CorePanel` (Host de SidePanels)

Todos os **SidePanels** dos plugins são hospedados em um dock lateral unificado chamado **`CorePanel`**, proporcionando uma experiência de usuário coesa para esses painéis.

**Benefícios:**

*   Organização e consistência visual para SidePanels.
*   Adição e remoção dinâmica de SidePanels.
*   Integração simplificada via API interna da CafeEngine.

---

## 3. Estrutura de Arquivos Padrão

Para manter a consistência e facilitar a navegação, todos os plugins da CafeEngine seguem uma estrutura de arquivos padrão.

```
addons/[plugin_name]/
├── plugin.cfg
├── components/
│   └── [plugin_name]_manager.gd
├── resources/
│   ├── base/
│   ├── data/
│   ├── config/
│   └── presets/
├── panel/
│   ├── [plugin_name]_panel.gd
│   └── [plugin_name]_panel.tscn
├── scripts/
│   └── editor_plugin.gd
├── icons/
│   └── [plugin_name]_icon.svg
├── docs/
│   ├── README.md
│   └── plugin_design_document.md
└── README.md
```

---

## 4. CoreEngine (Núcleo da Suíte)

O CoreEngine é o módulo central que fornece a infraestrutura básica para todos os outros plugins da CafeEngine.

### 4.1. Objetivo

O **CoreEngine** é o módulo central compartilhado por todos os plugins da CafeEngine. Ele fornece classes e funções de suporte para registro, comunicação e gerenciamento.

### 4.2. Componentes Principais

*   **`CoreEngine` (Singleton):** Gerencia plugins ativos e dependências.
*   **`CafeResource` (Base Class):** Resource padrão com integração automática de sinais e callbacks.
*   **`CafePanelHost`:** Controla a adição/remoção dinâmica de painéis no editor.

---

## 5. Convenção de Nomenclatura

Aderir a uma convenção de nomenclatura consistente é crucial para a legibilidade e manutenibilidade do código em toda a suíte.

| Tipo            | Sufixos Recomendados                  | Exemplo                                              |
| :-------------- | :------------------------------------ | :--------------------------------------------------- |
| Resource        | Data, Config, Behavior, Profile, Rule | `StateBehavior`, `AudioProfile`                      |
| Node            | Manager, Controller, Component        | `AudioManager`, `StateComponent`                     |
| Arquivo `.tres` | NomeEspecífico                        | `StateBehaviorIdle.tres`, `AudioProfile_Battle.tres` |

---

## 6. Dependências e Integração

As diretrizes de dependência e integração garantem que os plugins funcionem de forma harmoniosa e robusta.

*   Plugins devem declarar dependências opcionais em `plugin.cfg`.
*   O `CoreEngine` verifica compatibilidade de versão em runtime.
*   Nenhum plugin deve depender rigidamente de outro para funcionar.

---

## 7. Ciclo de Execução (Runtime Flow)

Este diagrama ilustra um exemplo genérico do fluxo de execução de um comportamento dentro da CafeEngine.

```text
[Node Principal (e.g., Player)]
   ↓
   Utiliza -> [Componente (e.g., StateComponent)]
   ↓
   Gerencia -> [Comportamento (e.g., StateBehaviorMove - Resource)]
   ↓
   Emite -> sinal (e.g., "transition_requested")
   ↓
   Capturado por -> [Gerenciador (e.g., StateMachineManager - Autoload)]
   ↓
   Atualiza -> Interface do Editor / Painel de Debug
```

---

## 8. Fases de Desenvolvimento

O desenvolvimento de cada plugin da CafeEngine segue um processo faseado para garantir a entrega de funcionalidades estáveis e bem testadas.

| Fase              | Objetivo                                              | Resultado                               |
| :---------------- | :---------------------------------------------------- | :-------------------------------------- |
| 1. Fundação (MVP) | Criar classes base e lógica essencial                 | Sistema funcional com demo inicial      |
| 2. Integração     | Registrar Custom Types, integrar ao editor            | Plugin funcional e visível no Inspector |
| 3. Expansão       | Adicionar biblioteca de Resources e Inspector plugins | Sistema rico e visualmente aprimorado   |
| 4. UI e Debug     | Desenvolver painel de editor e ferramentas visuais    | Interface completa e reativa            |
| 5. Documentação   | Criar README, exemplos e guias                        | Plugin pronto para uso e distribuição   |

---

## 9. Padrões de Qualidade de Código

A qualidade do código é uma prioridade, e todos os contribuidores devem aderir aos seguintes padrões.

*   Todos os scripts de Resource e Editor devem usar `@tool`.
*   Classes documentadas com docstring.
*   Sinais seguem convenção: `changed`, `updated`, `requested`, `completed`.
*   Nenhum Resource deve depender diretamente de Nodes.

---

## 10. Considerações Futuras

A CafeEngine está em constante evolução, e as seguintes considerações guiam o desenvolvimento futuro.

*   Integração cruzada entre plugins (ex: StateMachine <-> DataBehavior).
*   Editor visual unificado (gráfico de estados, eventos e diálogos).
*   Geração automática de Resources e código base.
*   Pooling, carregamento assíncrono e otimizações de performance.

---

## 11. Estrutura de Documentação Sugerida

Para manter a documentação organizada e acessível, sugerimos a seguinte estrutura.

*   `Blueprint.md` -> Filosofia e abordagem de programação visual.
*   `pdd_core.md` -> Filosofia e arquitetura da suíte.
*   `pdd_[plugin].md` -> Documento de design individual de cada plugin.
*   `pdd_suite_overview.md` -> Roadmap geral, versões e integrações planejadas.

---

**CafeEngine** é mais do que uma coleção de plugins: é um ecossistema unificado de desenvolvimento Godot, guiado pela ROP e projetado para acelerar a criação de jogos modulares, escaláveis e nativos ao editor.