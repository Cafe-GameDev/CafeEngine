# Plugins da Suíte CafeEngine

Este documento lista e descreve os plugins que compõem a suíte CafeEngine, detalhando suas funcionalidades, categorias e dependências. Todos os plugins são construídos sob a filosofia da Programação Orientada a Resources (ROP), onde `Resources` são tratados como entidades ativas e inteligentes.

---

## 1. Categoria: Core

### 1.1. CoreEngine
*   **Funcionalidades:** Atua como a infraestrutura fundamental da CafeEngine, fornecendo classes base, utilitários essenciais e estabelecendo padrões de integração, comunicação e gerenciamento. Inclui o `CorePanel` (host unificado para SidePanels) e o `CoreTopPanel` (editor universal de Resources).
*   **Dependências Essenciais:** Nenhuma (é a base da suíte).
*   **Dependências Opcionais:** Nenhuma.

---

## 2. Categoria: Editor Visual

### 2.1. BlueprintEditor
*   **Funcionalidades:** Oferece um editor visual/NoCode de alto nível, baseado em grafos, para construir e gerenciar a lógica de jogo. Orquestra `Resources` da ROP e serve como um host genérico para Módulos CrossPlugin de outros plugins.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** StateMachine (para o `BlueprintStateModule`), DataBehavior, EventPulse, etc. (para módulos de integração específicos).

---

## 3. Categoria: Áudio

### 3.1. AudioBlend
*   **Funcionalidades:** Otimiza o fluxo de trabalho de gerenciamento de áudio, automatizando a criação de `AudioStreamPlaylist`, `AudioStreamRandomizer` e `AudioStreamSynchronized` a partir de arquivos brutos. Organiza todos os recursos de áudio em um `AudioManifest` centralizado.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** StateMachine (para reagir a sinais de estado), EventPulse (para eventos de áudio).

---

## 4. Categoria: Comportamento/Lógica

### 4.1. StateMachine
*   **Funcionalidades:** Framework avançado para Máquina de Estados Paralela e em Camadas. O `StateComponent` gerencia `StateBehavior`s ativos simultaneamente em diferentes domínios. `StateBehavior`s encapsulam a lógica de um domínio funcional. O `StateMachine` (Autoload) gerencia estados globais do jogo e auxilia na depuração.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** BlueprintEditor (para visualização de grafos), DataBehavior (para `DataResource`s em `StateBehavior`s).

### 4.2. EventPulse
*   **Funcionalidades:** Fornece um sistema de eventos visual, reativo e dinâmico para gerenciar triggers e lógica de reação no jogo.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** BlueprintEditor (para editor visual de eventos), StateMachine (para eventos baseados em estado).

### 4.3. AIMind
*   **Funcionalidades:** Gerencia comportamentos de Inteligência Artificial, incluindo tomada de decisão, padrões de ataque, patrulha, perseguição e outras lógicas de IA, configuráveis via `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** StateMachine (para estados de IA), DataBehavior (para dados de IA), BlueprintEditor (para visualização de IA).

### 4.4. CombatSystem
*   **Funcionalidades:** Gerencia a lógica de combate, incluindo ataques corpo a corpo e à distância, defesa, reações a dano e sistemas de habilidades, tudo configurável através de `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** StateMachine (para estados de combate), DataBehavior (para dados de armas/habilidades), VFXEcho (para efeitos visuais de combate), AudioBlend (para sons de combate).

### 4.5. InteractionThread
*   **Funcionalidades:** Gerencia sequências de interação com objetos no mundo, como diálogos, cutscenes interativas e eventos contextuais, utilizando um fluxo modular baseado em `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** StateMachine (para estados de interação), DataBehavior (para dados de interação/diálogo), EventPulse (para triggers de interação).

---

## 5. Categoria: Dados/Assets

### 5.1. DataBehavior
*   **Funcionalidades:** Serve como a base para a definição e gerenciamento de dados e comportamentos de entidades (ex: `CharacterData`, `WeaponData`), todos implementados como `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** StateMachine (para `StateBehavior`s que usam `DataResource`s), BlueprintEditor (para visualização de dados).

### 5.2. ItemPool
*   **Funcionalidades:** Gerencia `Resources` que representam itens, como os de inventário ou coletáveis pelo jogador, otimizando a criação e reutilização.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** DataBehavior (para dados de itens).

### 5.3. WorldAtlas
*   **Funcionalidades:** Gerencia dados do mundo do jogo, como mapas, biomas, e pode incluir funcionalidades para geração procedural de terreno e estruturação de ambientes.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** AssetInstance (para popular o mundo), DataBehavior (para dados de biomas/terreno).

### 5.4. AssetInstance
*   **Funcionalidades:** Gerencia `Resources` que representam objetos e instâncias de assets (props, cenas) para geração procedural e para fornecer uma base de assets/cenas pré-configuradas no jogo.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** WorldAtlas (para geração procedural), DataBehavior (para dados de assets).

---

## 6. Categoria: Visual/Efeitos

### 6.1. VFXEcho
*   **Funcionalidades:** Gerencia efeitos visuais (partículas, shaders, etc.), com foco em efeitos que podem ser repetidos, ressoados ou encadeados, configuráveis via `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** EventPulse (para disparar VFX), CombatSystem (para VFX de combate).

### 6.2. EnvironmentBlend
*   **Funcionalidades:** Gerencia transições e misturas dinâmicas entre diferentes ambientes, permitindo efeitos visuais, sonoros ou de jogabilidade baseados em `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** VFXEcho (para efeitos visuais), AudioBlend (para efeitos sonoros).

---

## 7. Categoria: Câmera

### 7.1. CameraRig
*   **Funcionalidades:** Controla a câmera do jogo, incluindo transições suaves, efeitos dinâmicos (como shake e tilt) e perfis de câmera configuráveis via `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** StateMachine (para estados de câmera), EventPulse (para eventos de câmera).

---

## 8. Categoria: UI

### 8.1. UIFrame
*   **Funcionalidades:** Fornece uma estrutura e base modular para a interface do usuário, incluindo componentes reutilizáveis, temas e layouts, tudo gerenciado por `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** DataBehavior (para dados de UI), EventPulse (para eventos de UI).

---

## 9. Categoria: Progressão

### 9.1. ProgressionSystem
*   **Funcionalidades:** Gerencia a progressão do jogador, incluindo sistemas de níveis, experiência, desbloqueio de habilidades e conquistas, configuráveis via `Resources`.
*   **Dependências Essenciais:** CoreEngine.
*   **Dependências Opcionais:** DataBehavior (para dados de progressão), EventPulse (para eventos de progressão).
