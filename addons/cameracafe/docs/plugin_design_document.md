# CameraCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-07
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **CameraCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar comportamentos de câmera de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem comportamentos complexos de câmera como Resources.

### 1.2. Filosofia

-   **Modularidade:** Comportamentos de câmera (seguir, tremer, cinemáticas) são domínios separados e autocontidos, que podem ser desenvolvidos e testados de forma independente.
-   **Reutilização:** Um `CameraBehavior` (ex: `CameraBehaviorFollow`) pode ser criado uma vez e reutilizado em múltiplas câmeras ou situações com configurações diferentes.
-   **Design Visual e Reativo:** A lógica deve ser tão visual quanto possível, e o sistema deve ser reativo a eventos, integrando-se perfeitamente ao sistema de sinais e nós do Godot.
-   **`Resource` como Objeto Ativo:** Nossos `CameraBehavior`s não são meros contêineres de dados. Eles são objetos inteligentes com sua própria lógica, estado interno e capacidade de emitir sinais para comunicar suas intenções. A arquitetura reflete a filosofia de que o próprio comportamento é inteligente, decidindo quando transicionar e não sendo constantemente verificado por um gerente externo.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O CameraCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por três elementos centrais que trabalham em conjunto para criar um sistema de comportamento de câmera em camadas.

### 2.1. `CameraComponent` (O Gerenciador de Comportamentos da Câmera)

-   **Tipo:** `Node`.
-   **Função:** É o motor de execução que vive em uma cena, anexado a uma `Camera2D` ou `Camera3D`. Ele gerencia um conjunto de `CameraBehavior`s ativos **simultaneamente**, organizados em "camadas" ou "domínios" funcionais (ex: "movimento", "efeitos").
-   **Propriedades Chave:**
    -   `@export var initial_behaviors: Array[Dictionary]`: Define os comportamentos iniciais e seus domínios no Inspector. A estrutura de cada entrada do dicionário é `{"domain": StringName, "behavior": CameraBehavior}`.
    -   `var active_behaviors: Dictionary`: Armazena os `CameraBehavior`s atualmente ativos, usando o nome do domínio como chave.
    -   `var _is_transitioning := false`: Um flag interno para garantir transições seguras e evitar loops.
-   **Sinais Emitidos:**
    -   `signal behavior_changed(domain: StringName, previous: Resource, next: Resource)`: Emitido após uma transição de comportamento bem-sucedida em um domínio.
    -   `signal behavior_entered(domain: StringName, behavior: Resource)`: Emitido quando um comportamento entra em um domínio.
    -   `signal behavior_exited(domain: StringName, behavior: Resource)`: Emitido quando um comportamento sai de um domínio.
-   **Lógica Principal:**
    1.  **Ciclo de Vida:** Em `_process` e `_physics_process`, itera sobre todos os `active_behaviors` e executa seus respectivos métodos, permitindo comportamentos paralelos (ex: seguir um alvo e tremer).
    2.  **Gerenciador de Eventos:** Atua como um "broker". Ouve sinais de nós externos (configurados via Inspector) e os propaga para **todos** os `CameraBehavior`s ativos através da função `handle_event()`.
    3.  **Executor de Transição:** Ouve o sinal `transition_requested(domain: StringName, next_behavior: Resource)` emitido pelos `CameraBehavior`s e executa a troca de comportamento de forma segura, substituindo o behavior apenas no domínio especificado.
    4.  **`is_in_behavior(domain: StringName, behavior_class: StringName) -> bool`**: Função auxiliar para verificar se um domínio está em um comportamento específico.

### 2.2. `CameraBehavior` (O Comportamento da Câmera)

-   **Tipo:** `Resource`.
-   **Função:** Encapsula a lógica completa de um comportamento de câmera (Seguir, Tremer, Cinemática).
-   **Comunicação (Saída):**
    -   `signal transition_requested(domain: StringName, next_behavior: Resource)`: Sinal para solicitar a troca do behavior ativo dentro de um domínio específico.
    -   Pode emitir outros sinais específicos de ação (ex: `camera_effect_finished`).
-   **Comunicação (Entrada):**
    -   `func enter(camera: Camera3D/Camera2D, owner: Node)`: Chamado uma vez quando o comportamento se torna ativo.
    -   `func exit(camera: Camera3D/Camera2D, owner: Node)`: Chamado uma vez quando o comportamento deixa de ser ativo.
    -   `func process(camera: Camera3D/Camera2D, owner: Node, delta: float)`: Chamado a cada frame do jogo.
    -   `func physics_process(camera: Camera3D/Camera2D, owner: Node, delta: float)`: Chamado a cada frame de física.
    -   `func handle_event(camera: Camera3D/Camera2D, owner: Node, event_name: StringName, payload: Variant)`: Método virtual que permite ao comportamento reagir a eventos externos.

### 2.3. `CameraControl` (O Autoload Singleton)

-   **Tipo:** `Node` (Singleton).
-   **Função:** Orquestrador de alto nível para todas as câmeras do jogo.
-   **Papel 1 (Registro de Câmeras):** Mantém um registro de todos os `CameraComponent`s ativos na cena para depuração e controle centralizado.
-   **Papel 2 (API Global):** Fornece métodos para:
    -   `set_active_camera(camera_component: CameraComponent)`: Define qual `CameraComponent` está ativo (se houver múltiplos).
    -   `get_active_camera() -> CameraComponent`: Retorna a câmera ativa.
    -   `transition_to_camera(camera_component: CameraComponent, duration: float = 0.5)`: Gerencia transições suaves entre câmeras.
    -   `activate_behavior(camera_component: CameraComponent, domain: StringName, behavior: CameraBehavior)`: Ativa um comportamento específico em uma câmera.
    -   `deactivate_behavior(camera_component: CameraComponent, domain: StringName)`: Desativa um comportamento.

---

## 3. Estrutura de Arquivos Proposta

```
addons/cameracafe/
├── plugin.cfg
├── components/
│   ├── camera_component.gd
│   └── camera_component.tscn
├── resources/
│   ├── camera_config.tres
│   └── behaviors/
│       ├── camera_behavior.gd
│       ├── camera_behavior_follow.gd
│       ├── camera_behavior_shake.gd
│       ├── camera_behavior_cinematic.gd
│       └── camera_behavior_zoom.gd
├── panel/
│   ├── camera_panel.gd
│   └── camera_panel.tscn
├── scripts/
│   ├── editor_plugin.gd
│   └── camera_control.gd
└── icons/
    ├── camera_behavior_icon.svg
    └── camera_component_icon.svg
```

---

## 4. Catálogo de `CameraBehavior`s Propostos

| # | Nome do Resource (`class_name`) | Função Principal | Parâmetros Chave (Exemplos) |
|---|---|---|---|
| 1 | `CameraBehaviorFollow` | Segue um alvo (`Node2D`/`Node3D`) com offset e suavização. | `target: NodePath`, `offset: Vector3`, `lerp_speed: float` |
| 2 | `CameraBehaviorShake` | Aplica um efeito de tremor à câmera. | `intensity: float`, `duration: float`, `fade_out: float` |
| 3 | `CameraBehaviorCinematic` | Move a câmera por uma sequência de pontos/caminhos. | `path: Path3D/Path2D`, `duration: float`, `look_at_target: NodePath` |
| 4 | `CameraBehaviorZoom` | Controla o nível de zoom (2D) ou FOV (3D) da câmera. | `target_zoom: float`, `zoom_speed: float`, `min_zoom: float`, `max_zoom: float` |
| 5 | `CameraBehaviorTargetLock` | Trava a câmera em um alvo específico, mantendo-o visível. | `target: NodePath`, `offset: Vector3`, `dead_zone: Rect2` |
| 6 | `CameraBehaviorFixed` | Mantém a câmera em uma posição e rotação fixas. | `position: Vector3`, `rotation: Vector3` |
| 7 | `CameraBehaviorOrbit` | Faz a câmera orbitar um ponto ou alvo. | `target: NodePath`, `radius: float`, `speed: float` |
| 8 | `CameraBehaviorTransition` | Gerencia uma transição suave entre duas posições/comportamentos. | `from_behavior: CameraBehavior`, `to_behavior: CameraBehavior`, `duration: float` |

---

## 5. Arquitetura de Interface (UI)

A interface do CameraCafe será dividida em componentes modulares para uma experiência de usuário limpa e focada.

-   **`CafePanel` (O Host da Dock):** Um contêiner simples que fica na dock lateral do editor. Sua única função é abrigar os painéis dos diferentes plugins da suíte CafeEngine.

-   **`CameraPanel` (O Navegador / Visualizador):** O painel principal do CameraCafe, filho do `CafePanel`. Sua responsabilidade é a **visualização e gerenciamento** dos comportamentos de câmera.
    -   **Funcionalidades:**
        -   **Seletor de Câmera:** `OptionButton` para alternar entre `CameraComponent`s ativos na cena.
        -   **Lista de Comportamentos:** Exibe os `CameraBehavior`s ativos para a câmera selecionada.
        -   **Ferramentas de Criação:** Botões para criar novos `CameraBehavior`s a partir de templates.
        -   **Integração com Inspector:** Selecionar um comportamento no painel exibe suas propriedades no Inspector principal do Godot.

---

## 6. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `camera_behavior.gd` com suas funções virtuais e o sinal `transition_requested`.
-   [ ] **Criar Componente:** Implementar `camera_component.gd` com a arquitetura de domínios, transições seguras (`_is_transitioning`), e sinais (`behavior_changed`, `behavior_entered`, `behavior_exited`).
-   [ ] **Criar `CameraControl`:** Implementar o autoload singleton.
-   [ ] **Criar Comportamentos Essenciais:** Desenvolver `CameraBehaviorFollow` e `CameraBehaviorShake`.
-   [ ] **Ajustar Estrutura de Pastas:** Mover `CameraBehavior`s para `resources/behaviors/`.
-   **Objetivo:** Ter um sistema funcional de câmera com comportamentos paralelos e transições seguras.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `CameraBehavior` e `CameraComponent` como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação de `CameraBehavior`s.
    -   Configurar Autoload para `CameraControl`.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `CameraBehavior`s para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Expansão da Biblioteca de Comportamentos e Controles Customizados

-   [ ] **Desenvolver `CameraBehaviorCinematic`:** Criar um comportamento para câmeras cinemáticas.
-   [ ] **Desenvolver `CameraBehaviorZoom`:** Criar um comportamento para controle de zoom/FOV.
-   [ ] **Desenvolver outros `CameraBehavior`s:** Implementar mais comportamentos do catálogo para cobrir domínios comuns.
-   [ ] **Controles Customizados no Inspector:** Implementar `EditorInspectorPlugin` para adicionar botões de atalho, validações visuais e previews no Inspector para `CameraBehavior`s.
-   **Objetivo:** Oferecer uma biblioteca robusta de comportamentos de câmera e uma experiência de edição mais interativa.

### Fase 4: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `camera_panel.tscn` e `camera_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar os `CameraComponent`s ativos na cena.
    -   Mostrar o comportamento ativo em tempo real durante a execução do jogo.
    -   Botões de atalho para criar novos `CameraBehavior` resources.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de sistemas de câmera.

### Fase 5: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversos comportamentos e funcionalidades do CameraCafe.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 7. Considerações Futuras (Pós-MVP)

-   **Editor Visual de Comportamentos:** Uma ferramenta de `GraphEdit` para conectar visualmente os comportamentos e suas transições.
-   **Presets de Câmera:** Um sistema para salvar e carregar configurações completas de câmera (incluindo `CameraComponent` e seus `CameraBehavior`s) como um único Resource.
-   **Integração com `StateCafe`:** Permitir que `StateBehavior`s acionem `CameraBehavior`s específicos.
