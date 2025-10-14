# CafeEngine - Integração e Features Cross-Plugin

A força da CafeEngine reside na sua capacidade de orquestrar múltiplos plugins de forma coesa, permitindo que eles se relacionem e colaborem para criar sistemas de jogo complexos. Este documento detalha a filosofia e os mecanismos por trás da implementação de features que abrangem múltiplos plugins.

## 1. Filosofia de Integração

A integração entre plugins na CafeEngine é guiada pelos seguintes princípios:

*   **Desacoplamento:** Plugins devem ser capazes de funcionar de forma independente, mas se beneficiar da presença de outros. A comunicação deve ser via interfaces bem definidas (sinais, Resources) e não por dependências rígidas de código.
*   **Reatividade:** A comunicação é predominantemente baseada em eventos (sinais), permitindo que os plugins reajam a mudanças de estado ou ações de outros sem um conhecimento profundo de sua implementação interna.
*   **Orientação a Resources (ROP):** Resources atuam como o "contrato" de dados e comportamento entre plugins. Um Resource criado por um plugin pode ser consumido ou modificado por outro.
*   **Autoloads como Orquestradores:** Singletons Autoload fornecem pontos de acesso globais e centralizam a lógica de coordenação de alto nível.

## 2. Mecanismos de Comunicação Cross-Plugin

### 2.1. Sinais (Signals)

O principal mecanismo para comunicação reativa. Um plugin emite um sinal quando um evento significativo ocorre, e outros plugins podem se conectar a ele para reagir.

**Exemplo:**
*   Um `StateBehavior` do **StateMachine** pode emitir um sinal `attack_performed(damage_amount)` quando um ataque é executado.
*   O **AudioManager** pode se conectar a este sinal para tocar um som de "hit" correspondente.
*   O **DataBehavior** pode se conectar para registrar estatísticas de combate.

### 2.2. Autoloads (Singletons Globais)

Plugins como `StateMachine` e `AudioManager` são Autoloads, tornando-os acessíveis globalmente. Isso permite que um plugin chame métodos ou acesse propriedades de outro Autoload diretamente, quando a interação é de alto nível e bem definida.

**Exemplo:**
*   Um `StateBehavior` do **StateMachine** pode chamar `AudioManager.play_sfx("player_jump")` para tocar um som de pulo.
*   O **CoreEngine** atua como um hub central, fornecendo acesso a painéis e funcionalidades compartilhadas.

### 2.3. Resources Compartilhados

Resources são a espinha dorsal da ROP. Um Resource definido por um plugin pode ser referenciado e utilizado por outro.

**Exemplo:**
*   Um `StateBehavior` do **StateMachine** pode ter uma propriedade `@export var move_data: MoveData`, onde `MoveData` é um `DataResource` definido pelo **DataBehavior**. Isso permite que a lógica de movimento do StateMachine seja configurada por dados gerenciados pelo DataBehavior.
*   Um `AudioProfile` do **AudioManager** pode ser referenciado por um `StateBehavior` para definir o som de "passos" específico para um estado.

## 3. Diretrizes para Implementação de Features Cross-Plugin

Ao desenvolver funcionalidades que envolvem múltiplos plugins, considere o seguinte:

*   **Defina Contratos Claros:** Quais sinais serão emitidos? Quais Resources serão compartilhados e qual sua estrutura? Quais métodos dos Autoloads serão públicos para interação?
*   **Documente a Integração:** Cada plugin deve documentar explicitamente como ele pode interagir com outros plugins da suíte, incluindo exemplos de uso.
*   **Evite Acoplamento Forte:** Um plugin não deve *exigir* a presença de outro para funcionar. Se houver uma dependência, ela deve ser opcional e tratada com segurança (ex: verificar se o Autoload existe antes de tentar acessá-lo).
*   **Use o CoreEngine:** O `CoreEngine` pode atuar como um mediador ou um ponto de registro para funcionalidades cross-plugin, garantindo uma integração mais limpa.

## 4. Exemplos de Interação Cross-Plugin

*   **StateMachine + AudioManager:**
    *   `StateBehaviorAttack` emite `attack_hit_enemy`. `AudioManager` toca `sfx_hit_enemy`.
    *   `StateBehaviorMove` emite `player_footstep`. `AudioManager` toca `sfx_footstep`.
*   **StateMachine + DataBehavior:**
    *   `StateBehaviorMove` usa um `MoveData` (do DataBehavior) para configurar sua velocidade e aceleração.
    *   `StateBehaviorAttack` usa um `WeaponData` (do DataBehavior) para determinar o dano e tipo de ataque.
*   **CoreEngine + Todos os Plugins:**
    *   O `CoreEngine` gerencia o `CorePanel`, onde os **SidePanels** de editor dos plugins são adicionados, criando uma interface unificada para esses painéis.
    *   O `CoreEngine` pode fornecer utilitários globais que todos os plugins podem usar.

A colaboração entre os plugins da CafeEngine é o que a torna uma suíte poderosa e flexível, permitindo a construção de jogos modulares e escaláveis.