# ☕ CafeEngine - A Filosofia Blueprint

Na CafeEngine, a "Filosofia Blueprint" é a nossa abordagem para trazer o poder e a ergonomia da programação visual, popularizada pela Unreal Engine, para o ambiente leve e flexível da Godot. Não se trata de recriar o sistema de Blueprints da Unreal, mas de adaptar seus princípios fundamentais ao ecossistema da Godot, utilizando `Resources` como a base para criar lógica de jogo de forma modular e visual.

---

## O Que é um "Blueprint" na CafeEngine?

Um "Blueprint" na CafeEngine não é um único tipo de arquivo, mas uma **combinação de `Resources` e `Nodes` que, juntos, formam um comportamento completo e reutilizável**.

A estrutura de um Blueprint é composta por três elementos principais:

1.  **`StateBehavior` (O Cérebro - Resource):**
    -   **O que é:** Um `Resource` que contém a **lógica** de um comportamento específico (ex: `StateBehaviorMove`, `StateBehaviorAttack`).
    -   **Função:** Define *o que* o comportamento faz, suas propriedades (como `velocidade` ou `dano`) e quando ele deve transicionar para outro estado. É o "cérebro" do Blueprint.
    -   **Vantagem:** Por ser um `Resource`, pode ser editado no Inspector, reutilizado em múltiplos personagens e versionado com Git.

2.  **`StateComponent` (O Executor - Node):**
    -   **O que é:** Um `Node` que você adiciona à sua cena (ex: no seu `CharacterBody2D`).
    -   **Função:** É o "executor" que roda a lógica contida nos `StateBehavior`s. Ele gerencia os estados ativos, processa as transições e serve como ponte entre a cena e a lógica do Blueprint.
    -   **Vantagem:** Mantém a cena limpa. Em vez de um script gigante no seu personagem, você tem apenas um `StateComponent` que gerencia todos os seus comportamentos.

3.  **`StateMachine` (O Orquestrador - Autoload):**
    -   **O que é:** Um `Node` singleton (Autoload) que serve como um orquestrador de alto nível.
    -   **Função:** Utiliza `StateBehavior`s especiais (como `GameStateScene`) para controlar transições entre cenas inteiras (ex: do `MainMenu` para o `Level1`). Também serve como um ponto central para depuração.
    -   **Vantagem:** Permite que você visualize e gerencie o fluxo do seu jogo da mesma forma que gerencia o comportamento de um personagem.

---

## Como a CafeEngine Transforma Isso em Programação Visual?

A "programação visual" na CafeEngine acontece em múltiplos níveis, cada um construído sobre o anterior:

### Nível 1: Edição no Inspector (A Base)

A forma mais fundamental de programação visual na CafeEngine é através do **Inspector da Godot**. Como toda a lógica de comportamento é baseada em `Resources` (`StateBehavior`), você pode:

-   **Ajustar propriedades em tempo real:** Mude a `velocidade` de um `StateBehaviorMove` ou o `dano` de um `StateBehaviorAttack` diretamente no Inspector.
-   **Conectar estados:** Arraste e solte um `Resource` de comportamento no campo de outro para definir transições (ex: conectar o `idle_state` no `move_state`).

Isso já reduz drasticamente a necessidade de codificar valores diretamente nos scripts.

### Nível 2: Ferramentas Visuais no Editor (O Futuro Próximo)

O próximo passo é a criação de **editores de grafos (`GraphEdit`)** dentro do painel da CafeEngine. Para o `StateMachine`, isso significa:

-   **Visualizar a Máquina de Estados:** Ver todos os `StateBehavior`s de um `StateComponent` como nós em um grafo.
-   **Conexões Visuais:** Desenhar linhas entre os nós para criar e visualizar as transições.
-   **Criação Rápida:** Arrastar e soltar tipos de `StateBehavior` de uma "Toolbox" para criar novos estados no grafo.

Isso transforma a lógica abstrata de uma máquina de estados em um diagrama interativo e fácil de entender.

---

## Vantagens da Abordagem Blueprint da CafeEngine

-   **Modularidade Real:** Cada `StateBehavior` é um arquivo `.tres` independente. Você pode criar uma biblioteca de comportamentos e reutilizá-los em diferentes personagens e sistemas.
-   **Colaboração Amigável:** Designers podem ajustar parâmetros de IA, movimento e ataques diretamente no Inspector, sem precisar tocar no código.
-   **Depuração Simplificada:** Com o editor de grafos, você pode ver visualmente qual estado está ativo e como o fluxo está progredindo, facilitando a identificação de bugs.
-   **"Godot-Native":** A abordagem utiliza os sistemas que a Godot já oferece (`Resources`, `Nodes`, `EditorPlugin`), garantindo performance e integração perfeitas.

A Filosofia Blueprint da CafeEngine é sobre empoderar os desenvolvedores a **pensar em sistemas e fluxos**, em vez de se prenderem a linhas de código, resultando em um desenvolvimento mais rápido, organizado e intuitivo.