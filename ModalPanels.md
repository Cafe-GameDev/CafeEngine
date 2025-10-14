# Planejamento dos `ModalPanel`s (DataBehavior e StateMachine)

Com o `CoreTopPanel` assumindo a função de editor de texto/código para Resources, os `ModalPanel`s do DataBehavior e StateMachine terão propósitos mais especializados e visuais.

## 1. `DataBehavior ModalPanel` (`addons/data_behavior/panel/data_modal_panel.tscn`)

**Objetivo:** Servir como um inspetor visual e editor de dados aprimorado para `DataResource`s.

**Funcionalidades:**

*   **Inspetor Visual:** Exibirá as propriedades de um `DataResource` de forma mais rica e interativa do que o Inspector padrão do Godot.
    *   **Controles Customizados:** Para tipos de dados complexos (ex: `Array[Vector2]` pode ter um editor de pontos em 2D, `Color` um seletor de cores, `PackedScene` um preview da cena).
    *   **Categorização e Agrupamento:** Organização lógica das propriedades, similar ao Nível 1 do planejamento visual do StateMachine.
*   **Validação de Dados:** (Futuro) Feedback visual imediato sobre a validade dos dados inseridos (ex: valores fora de um range, referências nulas).
*   **Preview:** (Futuro) Uma aba ou área dedicada para visualizar o impacto dos dados (ex: um modelo 3D de arma para `WeaponData`, um mapa simplificado para `GameStateData`).

## 2. `StateMachine ModalPanel` (`addons/state_machine/panel/state_modal_panel.tscn`)

**Objetivo:** Servir como um editor visual de blueprints para `StateBehavior`s e `StateComponent`s, e um inspetor aprimorado.

**Funcionalidades:**

*   **Editor de Blueprint (GraphEdit):**
    *   **Visualização de Grafo:** Exibirá um `GraphEdit` onde `StateBehavior`s são representados como `GraphNode`s e as transições como conexões.
    *   **Criação e Conexão:** Permitirá arrastar e soltar tipos de `StateBehavior` de uma "Toolbox" para criar novos nós, e conectar esses nós visualmente.
    *   **Edição de Transições:** Ao clicar em uma conexão, um sub-painel ou outro modal pode abrir para configurar as condições e ações da transição.
*   **Configuração do `StateComponent`:**
    *   Uma aba ou seção dedicada para configurar os `initial_behaviors` do `StateComponent` (domínios, behaviors).
    *   Interface de arrastar e soltar para associar `StateBehavior`s a domínios específicos.
*   **Inspetor de `StateBehavior`:**
    *   Ao selecionar um `GraphNode` no editor de blueprint, suas propriedades serão exibidas de forma aprimorada (similar ao `DataBehavior ModalPanel`).
*   **Depuração Visual:** (Futuro) Durante a execução do jogo, o grafo pode destacar o `StateBehavior` ativo, mostrando o fluxo da máquina de estados em tempo real.
