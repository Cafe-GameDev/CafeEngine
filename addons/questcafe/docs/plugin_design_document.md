# QuestCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-07
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **QuestCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar quests e objetivos de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem quests complexas do seu jogo como Resources.

### 1.2. Filosofia

-   **Quests como Resources:** Todas as definições de quests (objetivos, recompensas, pré-requisitos, estados) são tratadas como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre a definição da quest e a lógica de jogo que a implementa, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e desenvolvedores editem e ajustem os detalhes das quests diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de definições de quests entre diferentes NPCs, eventos ou fases do jogo.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O QuestCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `QuestLog` (O Gerenciador de Quests)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para todas as quests ativas e concluídas do jogo. Ele pode carregar, armazenar e fornecer acesso a `QuestData`s.
-   **Funcionalidades Planejadas:**
    -   Adicionar, remover e atualizar o progresso de quests.
    -   Gerenciar o estado das quests (ativas, concluídas, falhadas).
    -   Emitir sinais para notificar o UI ou outros sistemas sobre mudanças no log de quests.

### 2.2. `QuestData` (A Base para Definições de Quests)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todas as definições de quests específicas do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
-   **Exemplos de Implementação:**
    -   `FetchQuest`: Coletar X itens.
    -   `KillQuest`: Derrotar Y inimigos.
    -   `ExploreQuest`: Visitar Z locais.

---

## 3. Estrutura de Arquivos Proposta

```
addons/questcafe/
├── plugin.cfg
├── components/
│   └── quest_log.gd
├── resources/
│   ├── quest_config.tres
│   └── quest_data/ # Subpasta para todos os QuestData (recursos)
│       ├── quest_data.gd
│       ├── fetch_quest.gd
│       └── kill_quest.gd
├── panel/
│   ├── quest_panel.gd
│   └── quest_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── quest_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `quest_data.gd` como a classe base para todos os recursos de quest.
-   [ ] **Criar `QuestLog`:** Implementar `quest_log.gd` como um autoload singleton.
-   [ ] **Criar Definições de Quests de Exemplo:** Desenvolver `FetchQuest` e `KillQuest` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir e gerenciar quests através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `QuestData` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação de `QuestData`s.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `QuestData`s para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `quest_panel.tscn` e `quest_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar as `QuestData`s carregadas.
    -   Ferramentas para criar e editar `QuestData`s.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de quests.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversas `QuestData`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Editor Visual de Fluxo de Quests:** Uma ferramenta visual para criar e gerenciar o fluxo de quests e suas dependências.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `DialogueCafe` para diálogos de quests, `InventoryCafe` para recompensas).
