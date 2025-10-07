# StateCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-07
**Autor:** Gemini (em colaboração com Bruno)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **StateCafe** é um framework avançado para Godot Engine 4.x, projetado para simplificar e potencializar a criação de lógicas de comportamento complexas. Ele implementa uma arquitetura de **Máquina de Estados Paralela e em Camadas (Layered/Parallel State Machine)**, onde comportamentos são encapsulados em `Resource`s reutilizáveis.

### 1.2. Filosofia

-   **Modularidade:** Comportamentos de movimento, combate e IA são domínios separados e autocontidos, que podem ser desenvolvidos e testados de forma independente.
-   **Reutilização:** Um `StateBehavior` (ex: `StateBehaviorAIPatrol`) pode ser criado uma vez e reutilizado em múltiplos tipos de inimigos com configurações diferentes.
-   **Design Visual e Reativo:** A lógica deve ser tão visual quanto possível, e o sistema deve ser reativo a eventos, integrando-se perfeitamente ao sistema de sinais e nós do Godot.
-   **`Resource` como Objeto Ativo:** Nossos `StateBehavior`s não são meros contêineres de dados. Eles são objetos inteligentes com sua própria lógica, estado interno e capacidade de emitir sinais para comunicar suas intenções.

---

## 2. Arquitetura Principal

O sistema é composto por três elementos centrais que trabalham em conjunto.

### 2.1. `StateComponent` (O Gerenciador de Comportamentos)

-   **Tipo:** `Node`.
-   **Função:** É o motor de execução que vive em uma cena. Ele gerencia um conjunto de `StateBehavior`s ativos simultaneamente, organizados em "camadas" ou "domínios" funcionais.
-   **Propriedades Chave:**
    -   `@export var initial_behaviors: Array[Dictionary]`: Define os comportamentos iniciais e seus domínios no Inspector. Ex: `[{"domain": "movement", "behavior": res://...}, {"domain": "action", "behavior": res://...}]`
    -   `var active_behaviors: Dictionary`: Armazena os `StateBehavior`s atualmente ativos, usando o nome do domínio como chave.
-   **Lógica Principal:**
    1.  **Ciclo de Vida:** Em `_process` e `_physics_process`, itera sobre todos os `active_behaviors` e executa seus respectivos métodos.
    2.  **Gerenciador de Eventos:** Atua como um "broker". Ouve sinais de nós externos (configurados via Inspector) e os propaga para os `StateBehavior`s ativos através da função `handle_event()`.
    3.  **Executor de Transição:** Ouve o sinal `transition_requested` emitido pelos `StateBehavior`s e executa a troca de estado de forma segura e centralizada.

### 2.2. `StateBehavior` (A Sub-Máquina / Domínio Funcional)

-   **Tipo:** `Resource`.
-   **Função:** Encapsula a lógica completa de um domínio funcional (Movimento, Combate, IA, etc.). É, na prática, uma máquina de estados autocontida.
-   **Lógica Interna:** Gerencia seus próprios **micro-estados** (ex: `IDLE`, `WALK`, `RUN` dentro de um `StateBehaviorMove`) usando estruturas como `Enums` ou `Dictionaries`.
-   **Comunicação (Saída):**
    -   `signal transition_requested(next_behavior: Resource)`: Sinal principal para solicitar a troca de um `StateBehavior` por outro dentro do mesmo domínio.
    -   Pode emitir outros sinais específicos de ação (ex: `sound_requested`, `effect_spawned`).
-   **Comunicação (Entrada):**
    -   `func handle_event(owner: Node, event_name: StringName, payload: Variant)`: Método virtual que permite ao estado reagir a eventos externos propagados pelo `StateComponent`.

### 2.3. `StateMachine` (O Autoload Singleton)

-   **Tipo:** `Node` (Singleton).
-   **Função:** Orquestrador de alto nível com um duplo papel.
-   **Papel 1 (Observador de Entidades):**
    -   Mantém um registro de todos os `StateComponent`s ativos na cena.
    -   Permite que o `StatePanel` (UI) inspecione e depure qualquer máquina de estados de entidade em tempo real.
-   **Papel 2 (Executor de Estados Globais):**
    -   Funciona como sua própria máquina de estados para gerenciar o fluxo geral do jogo.
    -   Utiliza `StateBehavior`s de alto nível, como `GameStateScene`, para controlar transições entre menus, níveis, cutscenes, etc.

---

## 3. Catálogo de `StateBehavior`s Propostos

(Esta seção consolida o `behaviors_plan01.md`)

| # | Nome do Resource (`class_name`) | Função Principal | Micro-Estados Internos (Exemplos) | Estrutura Sugerida |
|---|---|---|---|---|
| **MOVIMENTO** | | | | |
| 1 | `StateBehaviorGroundMove` | Gerencia movimento terrestre. | `IDLE`, `WALK`, `RUN`, `CROUCH` | `Enum` |
| 2 | `StateBehaviorAerial` | Gerencia estados no ar. | `JUMP`, `FALL`, `DOUBLE_JUMP` | `Enum` |
| ... | *(e os outros 28 comportamentos que definimos)* | ... | ... | ... |

---

## 4. Interface do Usuário (`StatePanel`)

O `StatePanel` será a interface central para interagir com o sistema StateCafe.

-   **Contexto Duplo:** Um seletor permitirá alternar a visualização entre o **"StateMachine Global"** e o **`StateComponent` selecionado** na cena.
-   **Editor de Grafos (`GraphEdit`):** A área principal exibirá a máquina de estados do contexto selecionado, com `StateBehavior`s como nós e transições como conexões.
-   **Toolbox e Inspector:** Permitirá arrastar novos tipos de `StateBehavior` para o grafo e editar suas propriedades diretamente no Inspector do Godot ao selecionar um nó do grafo.
-   **Navegação Rápida:** Atalhos para inspecionar o `StateMachine` global e para abrir os scripts/resources dos estados com um duplo clique.

---

## 5. Plano de Desenvolvimento

O projeto seguirá um plano de 5 fases, começando com um MVP funcional e evoluindo para uma ferramenta completa com UI visual.

-   **Fase 1: Fundação (MVP):** Criar as classes base (`StateBehavior`, `StateComponent`) e validar a arquitetura paralela com um demo simples (Idle/Move/Attack).
-   **Fase 2: Integração como Plugin:** Formalizar o sistema como um plugin de editor, com tipos customizados e configuração de autoload.
-   **Fase 3: Expansão da Biblioteca:** Implementar a lista de `StateBehavior`s do catálogo.
-   **Fase 4: Painel de UI:** Desenvolver o `StatePanel` com o editor de grafos e ferramentas de depuração.
-   **Fase 5: Documentação e Exemplos:** Criar tutoriais, documentação completa e projetos de demonstração.
