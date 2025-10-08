# DialogueCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-07
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **DialogueCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar diálogos e conversas de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem árvores de diálogo complexas do seu jogo como Resources.

### 1.2. Filosofia

-   **Diálogos como Resources:** Todas as definições de diálogos (linhas, escolhas, ramificações, condições) são tratadas como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre a definição do diálogo e a lógica de jogo que o exibe, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e escritores editem e ajustem os detalhes dos diálogos diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de definições de diálogos entre diferentes NPCs, eventos ou situações do jogo.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O DialogueCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `DialogueManager` (O Gerenciador de Diálogos)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para iniciar, gerenciar e processar diálogos no jogo. Ele pode carregar, armazenar e fornecer acesso a `DialogueTree`s.
-   **Funcionalidades Planejadas:**
    -   Iniciar e avançar diálogos.
    -   Processar escolhas do jogador.
    -   Avaliar condições para ramificações de diálogo.
    -   Emitir sinais para notificar o UI ou outros sistemas sobre o progresso do diálogo.

### 2.2. `DialogueTree` (A Base para Definições de Diálogos)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todas as definições de diálogos específicos do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
-   **Exemplos de Implementação:**
    -   `LinearDialogue`: Diálogo simples e sequencial.
    -   `ChoiceDialogue`: Diálogo com opções de escolha para o jogador.
    -   `ConditionalDialogue`: Diálogo com ramificações baseadas em condições de jogo.

---

## 3. Estrutura de Arquivos Proposta

```
addons/dialoguecafe/
├── plugin.cfg
├── components/
│   └── dialogue_manager.gd
├── resources/
│   ├── dialogue_config.tres
│   └── dialogue_trees/ # Subpasta para todos os DialogueTree (recursos)
│       ├── dialogue_tree.gd
│       ├── linear_dialogue.gd
│       └── choice_dialogue.gd
├── panel/
│   ├── dialogue_panel.gd
│   └── dialogue_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── dialogue_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `dialogue_tree.gd` como a classe base para todos os recursos de diálogo.
-   [ ] **Criar `DialogueManager`:** Implementar `dialogue_manager.gd` como um autoload singleton.
-   [ ] **Criar Definições de Diálogos de Exemplo:** Desenvolver `LinearDialogue` e `ChoiceDialogue` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir e gerenciar diálogos através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `DialogueTree` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação de `DialogueTree`s.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `DialogueTree`s para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `dialogue_panel.tscn` e `dialogue_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar os `DialogueTree`s carregados.
    -   Ferramentas para criar e editar `DialogueTree`s.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de diálogos.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversas `DialogueTree`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Editor Visual de Diálogos:** Uma ferramenta visual baseada em `GraphEdit` para criar e gerenciar árvores de diálogo complexas.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `QuestCafe` para diálogos de quests, `LocalizationCafe` para tradução).
