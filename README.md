# CafeEngine Suite

[![CafeEngine](https://img.shields.io/badge/CafeEngine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

**CafeEngine** é uma suíte de plugins para Godot 4 que transforma `Resources` em ferramentas inteligentes, melhora workflows e permite criação visual de lógica complexa. A suíte é projetada para tornar o desenvolvimento de jogos mais rápido, organizado e intuitivo.

O principal objetivo da CafeEngine não é adicionar funcionalidades impossíveis de criar na Godot, mas sim **otimizar radicalmente o fluxo de trabalho** do desenvolvedor. Tudo que nossos plugins oferecem poderia ser feito manualmente, mas exigiria tempo, código repetitivo e organização manual.

---

## Pilares da CafeEngine

A CafeEngine é construída sobre os seguintes pilares fundamentais, que guiam o desenvolvimento de todos os seus plugins:

### 1. Programação Orientada a Resources (ROP)
Tratamos `Resources` não apenas como contêineres de dados, mas como **objetos de comportamento ativos e inteligentes**. A lógica de um comportamento (IA, padrões de ataque, perfis de áudio, etc.) é encapsulada diretamente no `Resource`, tornando-o reutilizável e configurável pelo Inspector.

> Leia mais sobre a filosofia ROP em nosso [manifesto](ROP.md).

### 2. Código Visual (Blueprints)
Inspirado em sistemas como o **Blueprint da Unreal Engine**, a CafeEngine oferece um fluxo de trabalho visual baseado em grafos. No `StateMachine`, por exemplo, cada `StateBehavior` é representado como um nó em um editor de grafos, permitindo criar máquinas de estado complexas de forma intuitiva.

> Saiba mais sobre a filosofia de Código Visual em [Blueprint.md](Blueprint.md).

### 3. Autoloads e Tipos Customizados (Nodes)
A CafeEngine utiliza `Autoloads` para gerenciamento global e `Custom Types` para integração nativa com o editor.

-   **Autoloads (Managers):** Orquestradores globais que coordenam sistemas. Ex.: `StateMachine` gerencia o fluxo do jogo, `AudioManager` controla o áudio.  
-   **Custom Types (Components):** Executores adicionados às cenas que aplicam a lógica definida nos Blueprints. Ex.: `StateComponent` conecta a cena à lógica de `StateBehavior`.

### 4. Painéis e Editores
A CafeEngine organiza suas ferramentas visuais em diferentes tipos de painéis, cada um com um propósito e nível de intrusividade específicos, garantindo um fluxo de trabalho otimizado no editor Godot. Para mais detalhes sobre cada tipo, consulte [Panels.md](Panels.md).

*   **TopPanel:** Painéis de alto nível que ocupam uma aba principal do editor, como o `CoreTopPanel`, que oferece um editor de texto universal para Resources.
*   **SidePanel:** Painéis laterais não intrusivos, ideais para configurações rápidas e acionamento de funções. O `CorePanel` é o host unificado para todos os SidePanels dos plugins da CafeEngine, como o `AudioPanel` do AudioManager.
*   **BottomPanel:** Painéis ancorados na parte inferior, usados para gerenciamento contextual e listas, como o `DataBottomPanel` e o `StateBottomPanel`.
*   **ModalPanel:** Janelas pop-up que facilitam a edição detalhada e a criação de novos Resources em um ambiente focado, como o `DataModalPanel` e o `StateModalPanel`.

### 5. Integração Cross-Plugin
A CafeEngine é projetada para que seus plugins trabalhem em conjunto, permitindo a criação de sistemas complexos através da comunicação e colaboração. Para entender como os plugins se relacionam e como desenvolver features que abrangem múltiplos módulos, consulte [CrossPlugin.md](CrossPlugin.md).

---

## Plugins da Suíte

A suíte CafeEngine é composta por diversos plugins, cada um focado em um domínio específico do desenvolvimento de jogos:

### CoreEngine
[![CoreEngine](https://img.shields.io/badge/CoreEngine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Núcleo da CafeEngine, fornecendo as bases para todos os outros plugins. Inclui o **CoreTopPanel**, um editor de texto universal para `Resources`, permitindo a visualização e edição direta de arquivos `.tres`.

> [Mais sobre o CoreEngine](addons/core_engine/README.md)

### AudioManager
[![AudioManager](https://img.shields.io/badge/AudioManager-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Gerencia áudio de forma robusta, transformando pastas de arquivos em `AudioStreamPlaylist`s, `AudioStreamRandomizer`s e outros `Resources` prontos para uso. O **AudioPanel** (painel lateral) oferece uma interface intuitiva para configurar caminhos, gerar manifestos e gerenciar recursos de áudio.

> [Mais sobre o AudioManager](addons/audio_manager/README.md)

### StateMachine
[![StateMachine](https://img.shields.io/badge/StateMachine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Framework de Máquina de Estados paralela e em camadas para IA, personagens e fluxo de jogo, utilizando `StateBehavior` resources. O **StateBottomPanel** permite a criação e edição de `StateBehavior`s e scripts, e o **StateModalPanel** facilita a edição detalhada de recursos de estado, oferecendo um espaço amplo para o trabalho.

> [Mais sobre o StateMachine](addons/state_machine/README.md)

### DataBehavior
[![DataBehavior](https://img.shields.io/badge/DataBehavior-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Gerencia e estrutura dados de jogo de forma modular e reutilizável através de Resources. O **DataBottomPanel** oferece uma interface para gerenciar e criar `DataResource`s e seus scripts associados, enquanto o **DataModalPanel** permite a edição detalhada e visual de `DataResource`s em uma janela modal, ideal para configurações complexas que demandam mais espaço.

> [Mais sobre o DataBehavior](addons/data_behavior/README.md)

---

## Contribuição

Este projeto é open-source e contribuições são bem-vindas.

Consulte nosso [guia de contribuição](CONTRIBUTING.md) para saber como ajudar. Para visualizar o futuro da suíte, veja nosso [Roadmap](roadmap.md).

---

## Licença

A CafeEngine é distribuída sob a Licença MIT.

Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.