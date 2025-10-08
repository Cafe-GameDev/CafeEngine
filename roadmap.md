# Roadmap da Suíte CafeEngine

Este documento apresenta o roadmap consolidado para a suíte de plugins CafeEngine, destacando as fases de desenvolvimento e as funcionalidades planejadas para cada plugin, com base na filosofia de Programação Orientada a Resources (ROP).

---

## ☕ Filosofia Central: Programação Orientada a Resources (ROP)

A CafeEngine é construída sobre a ideia de tratar o sistema `Resource` do Godot como **objetos de comportamento ativos e inteligentes**. Isso promove:

-   **Lógica Encapsulada:** Comportamentos autocontidos em `Resources`.
-   **Máxima Reutilização:** `Resources` configuráveis e reutilizáveis.
-   **Design Orientado a Dados:** Separação clara entre "o quê" (lógica e dados no `Resource`) e "como" (o `Node` que executa o comportamento).
-   **Fluxo de Trabalho "Godot-Native":** Configuração e gerenciamento via FileSystem e Inspector.

---

## 🧠 Plugin StateCafe: Máquinas de Estado Paralelas e em Camadas

**Objetivo:** Simplificar e aprimorar a criação de lógicas de comportamento complexas.

### Arquitetura Central:

1.  **`StateComponent` (Gerenciador de Comportamentos):** `Node` que executa `StateBehavior`s simultaneamente em "camadas".
2.  **`StateBehavior` (Sub-Máquina / Domínio Funcional):** `Resource` que encapsula a lógica de um domínio, gerencia micro-estados internos e emite `transition_requested`.
3.  **`StateMachine` (Singleton Autoload):** `Node` global para orquestração de alto nível, registro de `StateComponent`s e gerenciamento de estados globais (`GameStateScene`).

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [x] Implementar `state_behavior.gd` (base com funções virtuais e sinal `transition_requested`).
-   [x] Implementar `state_component.gd` (com domínios, transições seguras e sinais).
-   [x] Desenvolver `StateBehaviorIdle` e `StateBehaviorMove`.
-   [x] Implementar `GameStateScene` (para gerenciamento de cenas globais).
-   [x] Ajustar estrutura de pastas (`StateBehavior`s em `resources/behaviors/`).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource", configurar Autoload para `StateMachine`).
-   [ ] Inspector Aprimorado (Nível 1): Utilizar `_get_property_list()` para organizar propriedades em categorias (`logic/`, `transitions/`).

#### Fase 3: Expansão da Biblioteca de Estados e Controles Customizados

-   [ ] Desenvolver `StateBehaviorAttack` e `StateBehaviorJump`.
-   [ ] Implementar mais `StateBehavior`s do catálogo (`behaviors_plan01.md`).
-   [ ] Controles Customizados no Inspector (Nível 2): `EditorInspectorPlugin` para botões de atalho, validações visuais e previews.

#### Fase 4: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `state_panel.tscn` e `state_panel.gd`.
-   [ ] Implementar `StateModal` (para pop-ups de edição detalhada).
-   [ ] Funcionalidades do Painel: Visualização de máquinas de estado (Micro e Macro), estado ativo em tempo real, botões de atalho para criar `StateBehavior`s.

#### Fase 5: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor de Grafos Visual (`GraphEdit`).
-   Máquinas de Estado Hierárquicas (Sub-states).
-   Recurso de Transição (`StateTransition.tres`).
-   FSM Serializer, Behavior Templates, Live Hot-Reload.

---

## 🎵 AudioCafe: Sistema de Gerenciamento de Áudio

**Objetivo:** Simplificar o gerenciamento de áudio, automatizando a criação de `AudioStreamPlaylist`, `AudioStreamRandomizer` e `AudioStreamSynchronized`.

### Arquitetura Central:

1.  **`AudioConfig`:** `Resource` central de configuração do plugin.
2.  **`AudioManifest`:** `Resource` que atua como catálogo centralizado de todos os recursos de áudio.
3.  **`GenerateAlbuns`:** `EditorScript` responsável pela lógica de scan e geração de recursos.
4.  **`AudioPanel`:** UI principal do plugin no editor.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [x] Implementar `audio_config.gd`.
-   [x] Implementar `audio_manifest.gd`.
-   [x] Implementar `generate_albuns.gd`.
-   [x] Implementar `audio_manager.gd` (Autoload Singleton).
-   [x] Implementar `audio_position_2d.gd` e `audio_position_3d.gd`.

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [x] Criar `plugin.cfg`.
-   [x] Implementar `editor_plugin.gd` (registrar tipos customizados, configurar Autoload para `AudioManager`).
-   [x] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [x] Criar `audio_panel.tscn` e `audio_panel.gd`.
-   [x] Funcionalidades do Painel: Configuração de paths, trigger de geração, visualização de albuns e streams interativos, feedback de salvamento.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   `AudioZone2D/3D`, `AudioTrigger`, `AudioMixerPreset`, `AudioSequencer`, `AudioParameterController`, `AudioFeedback`.

---

## 📊 DataCafe: Gerenciamento e Estruturação de Dados de Jogo

**Objetivo:** Gerenciar e estruturar dados de jogo de forma modular e reutilizável através de Resources.

### Arquitetura Central:

1.  **`DataManager`:** `Node` (Autoload Singleton) para acesso global aos dados.
2.  **`DataResource`:** Classe base abstrata para todos os recursos de dados específicos do jogo.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `data_resource.gd` (classe base).
-   [ ] Implementar `data_manager.gd` (Autoload Singleton).
-   [ ] Criar `WeaponData`, `MoveData` e `GameStateData` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `data_panel.tscn` e `data_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `DataResource`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Validação de dados, Editor Visual de Dados, Integração com outros plugins.

---

## 🎥 CameraCafe: Comportamentos de Câmera

**Objetivo:** Gerenciar e estruturar comportamentos de câmera de forma modular e reutilizável.

### Arquitetura Central:

1.  **`CameraComponent`:** `Node` que gerencia `CameraBehavior`s ativos simultaneamente.
2.  **`CameraBehavior`:** `Resource` que encapsula a lógica de um comportamento de câmera.
3.  **`CameraControl`:** `Node` (Singleton) orquestrador de alto nível para todas as câmeras.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `camera_behavior.gd` (base com funções virtuais e sinal `transition_requested`).
-   [ ] Implementar `camera_component.gd` (com arquitetura de domínios, transições seguras e sinais).
-   [ ] Implementar `CameraControl` (Autoload Singleton).
-   [ ] Desenvolver `CameraBehaviorFollow` e `CameraBehaviorShake`.
-   [ ] Ajustar estrutura de pastas (`CameraBehavior`s em `resources/behaviors/`).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource", configurar Autoload para `CameraControl`).
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Expansão da Biblioteca de Comportamentos e Controles Customizados

-   [ ] Desenvolver `CameraBehaviorCinematic`, `CameraBehaviorZoom` e outros `CameraBehavior`s.
-   [ ] Controles Customizados no Inspector (`EditorInspectorPlugin`).

#### Fase 4: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `camera_panel.tscn` e `camera_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar `CameraComponent`s, mostrar comportamento ativo em tempo real, botões de atalho.

#### Fase 5: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Comportamentos, Presets de Câmera, Integração com `StateCafe`.

---

## ⚔️ CombatCafe: Sistemas de Combate

**Objetivo:** Gerenciar e estruturar sistemas de combate (tipos de dano, resistências, buffs/debuffs, habilidades) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`CombatSystem`:** `Node` (Autoload Singleton) para aplicar e gerenciar efeitos de combate.
2.  **`CombatEffect`:** Classe base abstrata para definições de efeitos de combate.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `combat_effect.gd` (classe base).
-   [ ] Implementar `combat_system.gd` (Autoload Singleton).
-   [ ] Criar `DamageEffect` e `BuffEffect` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `combat_panel.tscn` e `combat_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `CombatEffect`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Habilidades de Combate, Integração com outros plugins, Sistema de Alvos.

---

## 🛠️ CraftingCafe: Sistemas de Crafting

**Objetivo:** Gerenciar e estruturar sistemas de crafting (receitas, ingredientes, estações de trabalho) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`CraftingManager`:** `Node` (Autoload Singleton) para processar requisições de crafting.
2.  **`RecipeData`:** Classe base abstrata para definições de receitas.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `recipe_data.gd` (classe base).
-   [ ] Implementar `crafting_manager.gd` (Autoload Singleton).
-   [ ] Criar `BasicRecipe` e `StationRecipe` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `crafting_panel.tscn` e `crafting_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `RecipeData`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Receitas, Integração com outros plugins, Sistema de Descoberta de Receitas.

---

## 🎬 CutsceneCafe: Gerenciamento de Cutscenes

**Objetivo:** Gerenciar e estruturar cutscenes (sequências de eventos, câmeras, diálogos) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`CutscenePlayer`:** `Node` (Autoload Singleton) para iniciar e gerenciar a reprodução de cutscenes.
2.  **`CutsceneData`:** Classe base abstrata para definições de cutscenes.
3.  **`CutsceneEvent`:** Classe base abstrata para definir um único evento de cutscene.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `cutscene_data.gd` e `cutscene_event.gd` (classes base).
-   [ ] Implementar `cutscene_player.gd` (Autoload Singleton).
-   [ ] Criar `LinearCutscene` e `CameraMoveEvent` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `cutscene_panel.tscn` e `cutscene_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `CutsceneData`s e `CutsceneEvent`s, ferramentas de criação e edição, preview de cutscenes.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Cutscenes, Integração com outros plugins, Sistema de Skip Inteligente.

---

## 💬 DialogueCafe: Diálogos e Conversas

**Objetivo:** Gerenciar e estruturar diálogos e conversas de forma modular e reutilizável.

### Arquitetura Central:

1.  **`DialogueManager`:** `Node` (Autoload Singleton) para iniciar e processar diálogos.
2.  **`DialogueTree`:** Classe base abstrata para definições de diálogos.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `dialogue_tree.gd` (classe base).
-   [ ] Implementar `dialogue_manager.gd` (Autoload Singleton).
-   [ ] Criar `LinearDialogue` e `ChoiceDialogue` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `dialogue_panel.tscn` e `dialogue_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `DialogueTree`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Diálogos, Integração com outros plugins.

---

## 🗓️ EventCafe: Gerenciamento de Eventos

**Objetivo:** Gerenciar e estruturar eventos (gatilhos, ações, sequências) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`EventManager`:** `Node` (Autoload Singleton) para registrar e disparar eventos.
2.  **`GameEventData`:** Classe base abstrata para definições de eventos.
3.  **`EventAction`:** Classe base abstrata para definir uma única ação de evento.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `game_event_data.gd` e `event_action.gd` (classes base).
-   [ ] Implementar `event_manager.gd` (Autoload Singleton).
-   [ ] Criar `SimpleEvent` e `ChangeSceneAction` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `event_panel.tscn` e `event_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `GameEventData`s e `EventAction`s, ferramentas de criação e edição, teste de disparo de eventos.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Eventos, Integração com outros plugins, Sistema de Condições.

---

## 🤝 FactionCafe: Sistemas de Facções

**Objetivo:** Gerenciar e estruturar sistemas de facções (reputação, relações, alianças) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`FactionManager`:** `Node` (Autoload Singleton) para gerenciar facções e reputação.
2.  **`FactionData`:** Classe base abstrata para definições de facções.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `faction_data.gd` (classe base).
-   [ ] Implementar `faction_manager.gd` (Autoload Singleton).
-   [ ] Criar `PlayerFaction` e `EnemyFaction` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `faction_panel.tscn` e `faction_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `FactionData`s, ferramentas de criação e edição, simulação de mudanças de reputação.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Relações, Integração com outros plugins, Sistema de Eventos de Facção.

---

## 💬 FeedbackCafe: Feedback Visual e Sonoro

**Objetivo:** Gerenciar e estruturar feedback visual e sonoro (hitmarkers, pop-ups de dano, sons de UI, vibração) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`FeedbackManager`:** `Node` (Autoload Singleton) para disparar e gerenciar eventos de feedback.
2.  **`FeedbackEventData`:** Classe base abstrata para definições de eventos de feedback.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `feedback_event_data.gd` (classe base).
-   [ ] Implementar `feedback_manager.gd` (Autoload Singleton).
-   [ ] Criar `HitFeedback` e `UIFeedback` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `feedback_panel.tscn` e `feedback_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `FeedbackEventData`s, ferramentas de criação e edição, teste de disparo de feedback.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Feedback, Integração com outros plugins, Sistema de Prioridade/Filtragem.

---

## ⌨️ InputCafe: Inputs e Mapeamentos

**Objetivo:** Gerenciar e estruturar inputs e mapeamentos de forma modular e reutilizável.

### Arquitetura Central:

1.  **`InputManager`:** `Node` (Autoload Singleton) para acesso global aos perfis de input.
2.  **`InputProfile`:** Classe base abstrata para definições de perfis de input.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `input_profile.gd` (classe base).
-   [ ] Implementar `input_manager.gd` (Autoload Singleton).
-   [ ] Criar `KeyboardProfile` e `GamepadProfile` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `input_panel.tscn` e `input_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `InputProfile`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Remapeamento em Tempo de Execução, Editor Visual de Mapeamentos, Integração com outros plugins.

---

## 🤝 InteractionCafe: Sistemas de Interação

**Objetivo:** Gerenciar e estruturar sistemas de interação genéricos (botões, alavancas, portas, NPCs) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`InteractionHandler`:** `Node` (Autoload Singleton) para detectar e processar interações.
2.  **`InteractionData`:** Classe base abstrata para definições de interações.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `interaction_data.gd` (classe base).
-   [ ] Implementar `interaction_handler.gd` (Autoload Singleton).
-   [ ] Criar `SimpleInteraction` e `DialogueInteraction` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `interaction_panel.tscn` e `interaction_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `InteractionData`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Interações, Integração com outros plugins, Sistema de Prioridade.

---

## 🎒 InventoryCafe: Inventários e Itens

**Objetivo:** Gerenciar e estruturar inventários e itens de forma modular e reutilizável.

### Arquitetura Central:

1.  **`InventoryManager`:** `Node` (Autoload Singleton) para gerenciar múltiplos inventários.
2.  **`ItemData`:** Classe base abstrata para definições de itens.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `item_data.gd` (classe base).
-   [ ] Implementar `inventory_manager.gd` (Autoload Singleton).
-   [ ] Criar `ConsumableItem` e `EquipmentItem` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `inventory_panel.tscn` e `inventory_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `ItemData`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Inventário, Integração com outros plugins.

---

## 🎁 ItemDropCafe: Tabelas de Drop de Itens

**Objetivo:** Gerenciar e estruturar tabelas de drop de itens (inimigos, baús, chances, condições) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`ItemDropManager`:** `Node` (Autoload Singleton) para processar requisições de drop.
2.  **`DropTableData`:** Classe base abstrata para definições de tabelas de drop.
3.  **`DropItemEntry`:** Classe base abstrata para definir uma entrada de item em tabelas de drop.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `drop_table_data.gd` e `drop_item_entry.gd` (classes base).
-   [ ] Implementar `item_drop_manager.gd` (Autoload Singleton).
-   [ ] Criar `BasicDropTable` e `StandardDropEntry` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `item_drop_panel.tscn` e `item_drop_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `DropTableData`s e `DropItemEntry`s, ferramentas de criação e edição, simulação de drops.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Tabelas de Drop, Integração com outros plugins, Modificadores de Drop.

---

## 🌐 LocalizationCafe: Localização de Textos e Assets

**Objetivo:** Gerenciar e estruturar a localização (tradução) de textos, áudios e outros assets de forma modular e reutilizável.

### Arquitetura Central:

1.  **`LocalizationManager`:** `Node` (Autoload Singleton) para carregar e gerenciar dados de localização.
2.  **`LocaleData`:** Classe base abstrata para definições de localização.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `locale_data.gd` (classe base).
-   [ ] Implementar `localization_manager.gd` (Autoload Singleton).
-   [ ] Criar `TextLocaleData` e `AudioLocaleData` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `localization_panel.tscn` e `localization_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `LocaleData`s, ferramentas de criação e edição, preview de traduções.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Localização, Integração com outros plugins, Importação/Exportação de formatos padrão.

---

## 📜 QuestCafe: Quests e Objetivos

**Objetivo:** Gerenciar e estruturar quests e objetivos de forma modular e reutilizável.

### Arquitetura Central:

1.  **`QuestLog`:** `Node` (Autoload Singleton) para gerenciar quests ativas e concluídas.
2.  **`QuestData`:** Classe base abstrata para definições de quests.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `quest_data.gd` (classe base).
-   [ ] Implementar `quest_log.gd` (Autoload Singleton).
-   [ ] Criar `FetchQuest` e `KillQuest` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `quest_panel.tscn` e `quest_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `QuestData`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Fluxo de Quests, Integração com outros plugins.

---

## 📜 QuestLogCafe: Log de Quests do Jogador

**Objetivo:** Gerenciar e estruturar o log de quests do jogador (entradas, objetivos, status) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`QuestLogManager`:** `Node` (Autoload Singleton) para gerenciar o log de quests do jogador.
2.  **`QuestLogEntry`:** Classe base abstrata para definições de entradas de log de quests.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `quest_log_entry.gd` (classe base).
-   [ ] Implementar `quest_log_manager.gd` (Autoload Singleton).
-   [ ] Criar `BasicQuestLogEntry` (exemplo).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `quest_log_panel.tscn` e `quest_log_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `QuestLogEntry`s, ferramentas de criação e edição (para debug), simulação de progresso.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Integração com outros plugins, Editor Visual de Log de Quests, Persistência com `SaveCafe`.

---

## 💾 SaveCafe: Salvamento e Carregamento de Jogos

**Objetivo:** Gerenciar e estruturar o salvamento e carregamento de jogos de forma modular e reutilizável.

### Arquitetura Central:

1.  **`SaveManager`:** `Node` (Autoload Singleton) para gerenciar o salvamento e carregamento.
2.  **`SaveProfile`:** Classe base abstrata para definições de perfis de salvamento.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `save_profile.gd` (classe base).
-   [ ] Implementar `save_manager.gd` (Autoload Singleton).
-   [ ] Criar `PlayerSaveProfile` e `GameWorldSaveProfile` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `save_panel.tscn` e `save_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `SaveProfile`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Perfis de Salvamento, Integração com outros plugins.

---

## 💰 ShopCafe: Sistemas de Lojas

**Objetivo:** Gerenciar e estruturar sistemas de lojas (itens à venda, moedas, descontos, estoques) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`ShopManager`:** `Node` (Autoload Singleton) para gerenciar lojas e transações.
2.  **`ShopData`:** Classe base abstrata para definições de lojas.
3.  **`ShopItemData`:** Classe base abstrata para definir itens comercializáveis.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `shop_data.gd` e `shop_item_data.gd` (classes base).
-   [ ] Implementar `shop_manager.gd` (Autoload Singleton).
-   [ ] Criar `GeneralShop` e `StandardShopItem` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `shop_panel.tscn` e `shop_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `ShopData`s e `ShopItemData`s, ferramentas de criação e edição.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Lojas, Integração com outros plugins, Sistema de Reputação/Descontos.

---

## 🌳 SkillTreeCafe: Árvores de Habilidades

**Objetivo:** Gerenciar e estruturar árvores de habilidades (nós, requisitos, efeitos, desbloqueio) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`SkillTreeManager`:** `Node` (Autoload Singleton) para gerenciar árvores de habilidades.
2.  **`SkillTreeData`:** Classe base abstrata para definições de árvores de habilidades.
3.  **`SkillNodeData`:** Classe base abstrata para definir um nó de habilidade.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `skill_tree_data.gd` e `skill_node_data.gd` (classes base).
-   [ ] Implementar `skill_tree_manager.gd` (Autoload Singleton).
-   [ ] Criar `ClassSkillTree` e `StatBoostNode` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `skill_tree_panel.tscn` e `skill_tree_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `SkillTreeData`s e `SkillNodeData`s, ferramentas de criação e edição, visualização da árvore.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Árvores de Habilidades, Integração com outros plugins, Sistema de Reset/Respec.

---

## 👾 SpawnCafe: Gerenciamento de Spawners

**Objetivo:** Gerenciar e estruturar spawners (tipos de inimigos, frequência, áreas, condições) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`SpawnManager`:** `Node` (Autoload Singleton) para gerenciar spawners e controlar a taxa de spawn.
2.  **`SpawnerData`:** Classe base abstrata para definições de spawners.
3.  **`SpawnEntry`:** Classe base abstrata para definir uma entrada de entidade em spawners.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `spawner_data.gd` e `spawn_entry.gd` (classes base).
-   [ ] Implementar `spawn_manager.gd` (Autoload Singleton).
-   [ ] Criar `TimedSpawner` e `SingleEntityEntry` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `spawn_panel.tscn` e `spawn_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `SpawnerData`s e `SpawnEntry`s, ferramentas de criação e edição, simulação de spawns.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Spawners, Integração com outros plugins, Sistema de Dificuldade Dinâmica.

---

## ⏰ TimeCafe: Gerenciamento de Tempo

**Objetivo:** Gerenciar e estruturar o tempo no jogo (ciclo dia/noite, estações, calendário, velocidade do tempo) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`TimeController`:** `Node` (Autoload Singleton) para gerenciar o tempo no jogo.
2.  **`TimeCycleData`:** Classe base abstrata para definições de ciclos de tempo.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `time_cycle_data.gd` (classe base).
-   [ ] Implementar `time_controller.gd` (Autoload Singleton).
-   [ ] Criar `DayNightCycle` e `SeasonalCycle` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `time_panel.tscn` e `time_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `TimeCycleData`s, ferramentas de criação e edição, preview do ciclo de tempo.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Ciclos de Tempo, Integração com outros plugins, Sistema de Agendamento.

---

## 📚 TutorialCafe: Gerenciamento de Tutoriais

**Objetivo:** Gerenciar e estruturar tutoriais (passos, dicas, gatilhos, feedback) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`TutorialManager`:** `Node` (Autoload Singleton) para iniciar e gerenciar o progresso de tutoriais.
2.  **`TutorialData`:** Classe base abstrata para definições de tutoriais.
3.  **`TutorialStepData`:** Classe base abstrata para definir um passo de tutorial.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `tutorial_data.gd` e `tutorial_step_data.gd` (classes base).
-   [ ] Implementar `tutorial_manager.gd` (Autoload Singleton).
-   [ ] Criar `LinearTutorial` e `TextStep` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `tutorial_panel.tscn` e `tutorial_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `TutorialData`s e `TutorialStepData`s, ferramentas de criação e edição, preview de tutoriais.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Tutoriais, Integração com outros plugins, Sistema de Skip/Replay.

---

## ✨ VFXCafe: Efeitos Visuais

**Objetivo:** Gerenciar e estruturar efeitos visuais (VFX) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`VFXManager`:** `Node` (Autoload Singleton) para instanciar e gerenciar a reprodução de VFX.
2.  **`VFXData`:** Classe base abstrata para definições de efeitos visuais.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `vfx_data.gd` (classe base).
-   [ ] Implementar `vfx_manager.gd` (Autoload Singleton).
-   [ ] Criar `ParticleVFX` e `AnimationVFX` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `vfx_panel.tscn` e `vfx_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `VFXData`s, ferramentas de criação e edição, preview de VFX.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de VFX, Integração com outros plugins, Sistema de Pooling.

---

## ☁️ WeatherCafe: Sistemas de Clima

**Objetivo:** Gerenciar e estruturar sistemas de clima (tipos de clima, transições, efeitos visuais/sonoros) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`WeatherController`:** `Node` (Autoload Singleton) para gerenciar o clima no jogo.
2.  **`WeatherData`:** Classe base abstrata para definições de clima.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `weather_data.gd` (classe base).
-   [ ] Implementar `weather_controller.gd` (Autoload Singleton).
-   [ ] Criar `SunnyWeather` e `RainyWeather` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `weather_panel.tscn` e `weather_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `WeatherData`s, ferramentas de criação e edição, preview de clima.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Clima, Integração com outros plugins, Modificadores de Gameplay.

---

## 🗺️ WorldCafe: Dados do Mundo

**Objetivo:** Gerenciar e estruturar dados do mundo (pontos de interesse, regiões, biomas, eventos de área) de forma modular e reutilizável.

### Arquitetura Central:

1.  **`WorldManager`:** `Node` (Autoload Singleton) para gerenciar o estado do mundo.
2.  **`WorldRegionData`:** Classe base abstrata para definições de regiões do mundo.

### Plano de Desenvolvimento em Fases:

#### Fase 1: Fundação (MVP)

-   [ ] Implementar `world_region_data.gd` (classe base).
-   [ ] Implementar `world_manager.gd` (Autoload Singleton).
-   [ ] Criar `BiomeRegion` e `PointOfInterest` (exemplos).

#### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] Criar `plugin.cfg`.
-   [ ] Implementar `editor_plugin.gd` (registrar tipos customizados, adicionar opção "Create Resource").
-   [ ] Inspector Aprimorado: Utilizar `_get_property_list()` para organizar propriedades em categorias.

#### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] Criar `world_panel.tscn` e `world_panel.gd`.
-   [ ] Funcionalidades do Painel: Visualizar e gerenciar `WorldRegionData`s, ferramentas de criação e edição, visualização de regiões.

#### Fase 4: Documentação e Exemplos

-   [ ] Documentar o código.
-   [ ] Criar documentação externa (`docs/` do plugin).
-   [ ] Criar um projeto demo completo.

#### Considerações Futuras (Pós-MVP):

-   Editor Visual de Mundo, Integração com outros plugins, Geração Procedural.
