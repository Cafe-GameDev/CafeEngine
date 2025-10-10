# EventCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-08
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **EventCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar eventos (sequências de ações disparadas por gatilhos) de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem sequências de eventos complexas (com gatilhos, condições, ações encadeadas, atrasos) do seu jogo como Resources.

### 1.2. Filosofia

-   **Eventos como Resources:** Todas as definições de eventos (gatilhos, condições, lista de ações a serem executadas, atrasos, repetições) são tratadas como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre a definição do evento e a lógica de jogo que o dispara ou executa, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e desenvolvedores editem e ajustem os detalhes dos eventos diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de definições de eventos entre diferentes partes do seu jogo (ex: o mesmo `GameEventData` para abrir uma porta ou iniciar uma cutscene).

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O EventCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `EventManager` (O Gerenciador de Eventos)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para registrar, disparar e gerenciar a execução de eventos no jogo. Ele pode carregar, armazenar e fornecer acesso a `GameEventData`s.
-   **Funcionalidades Planejadas:**
    -   Registrar gatilhos para eventos (ex: colisão, interação, tempo decorrido).
    -   Disparar eventos com base em condições.
    -   Executar sequências de ações definidas nos `GameEventData`s.
    -   Emitir sinais para notificar outros sistemas sobre o início/fim de eventos (ex: `event_started`, `event_finished`).

### 2.2. `GameEventData` (A Base para Definições de Eventos)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todas as definições de eventos específicos do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector, definindo o gatilho, as condições e a lista de ações a serem executadas.
-   **Exemplos de Implementação:**
    -   `SimpleEvent`: Dispara uma única ação.
    -   `SequenceEvent`: Dispara uma série de ações em ordem.
    -   `ConditionalEvent`: Dispara ações apenas se certas condições forem atendidas.

### 2.3. `EventAction` (A Base para Ações de Eventos)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para definir uma única ação que pode ser executada como parte de um evento. Isso permite criar ações reutilizáveis e configuráveis.
-   **Exemplos de Implementação:**
    -   `ChangeSceneAction`: Muda para uma nova cena.
    -   `PlaySoundAction`: Toca um som.
    -   `SpawnObjectAction`: Instancia um objeto na cena.

---

## 3. Estrutura de Arquivos Proposta

```
addons/eventcafe/
├── plugin.cfg
├── components/
│   └── event_manager.gd
├── resources/
│   ├── event_config.tres
│   └── events/ # Subpasta para todos os GameEventData (recursos)
│       ├── game_event_data.gd
│       ├── simple_event.gd
│       └── sequence_event.gd
│   └── actions/ # Subpasta para todos os EventAction (recursos)
│       ├── event_action.gd
│       ├── change_scene_action.gd
│       └── play_sound_action.gd
├── panel/
│   ├── event_panel.gd
│   └── event_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── event_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `game_event_data.gd` e `event_action.gd` como classes base.
-   [ ] **Criar `EventManager`:** Implementar `event_manager.gd` como um autoload singleton.
-   [ ] **Criar Definições de Eventos e Ações de Exemplo:** Desenvolver `SimpleEvent` e `ChangeSceneAction` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir e disparar eventos através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `GameEventData`, `EventAction` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `event_panel.tscn` e `event_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar `GameEventData`s e `EventAction`s carregados.
    -   Ferramentas para criar e editar.
    -   Funcionalidade para testar o disparo de eventos no editor.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de sistemas de eventos.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversos `GameEventData`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Editor Visual de Eventos:** Uma ferramenta visual para criar e gerenciar o fluxo de eventos e suas ações.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `DialogueCafe` para diálogos, `QuestCafe` para atualização de quests, `VFXCafe` para efeitos visuais).
-   **Sistema de Condições:** Recursos dedicados para definir condições complexas para o disparo de eventos.
