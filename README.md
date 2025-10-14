# CafeEngine Suite

[![CafeEngine](https://img.shields.io/badge/CafeEngine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

**CafeEngine** é uma suíte de plugins para Godot 4 que transforma `Resources` em ferramentas inteligentes, melhora workflows e permite criação visual de lógica complexa. A suíte é projetada para tornar o desenvolvimento de jogos mais rápido, organizado e intuitivo.

---

## Visão Geral

O principal objetivo da CafeEngine não é adicionar funcionalidades impossíveis de criar na Godot, mas sim **otimizar radicalmente o fluxo de trabalho** do desenvolvedor. Tudo que nossos plugins oferecem poderia ser feito manualmente, mas exigiria tempo, código repetitivo e organização manual.

A CafeEngine fornece uma **camada de qualidade de vida** sobre a engine, permitindo que você se concentre no design do seu jogo, e não na configuração. A suíte é baseada em cinco pilares que se complementam para criar um fluxo de trabalho integrado e modular.

---

## Pilares da CafeEngine

### 1. Programação Orientada a Resources (ROP)
Tratamos `Resources` não apenas como contêineres de dados, mas como **objetos de comportamento ativos e inteligentes**. A lógica de um comportamento (IA, padrões de ataque, perfis de áudio, etc.) é encapsulada diretamente no `Resource`, tornando-o reutilizável e configurável pelo Inspector.

> Leia mais sobre a filosofia ROP em nosso [manifesto](ROP.md).

### 2. Visual Code (Blueprints)
Inspirado em sistemas como o **Blueprint da Unreal Engine**, a CafeEngine oferece um fluxo de trabalho visual baseado em grafos. No `StateMachine`, por exemplo, cada `StateBehavior` é representado como um nó em um editor de grafos, permitindo criar máquinas de estado complexas de forma intuitiva.

### 3. Autoloads e Custom Types (Nodes)
- **Autoloads (Managers):** Orquestradores globais que coordenam sistemas. Ex.: `StateMachine` gerencia o fluxo do jogo, `AudioManager` controla o áudio.  
- **Custom Types (Components):** Executores adicionados às cenas que aplicam a lógica definida nos Blueprints. Ex.: `StateComponent` conecta a cena à lógica de `StateBehavior`.

### 4. Panels e Editors
Painéis e ferramentas visuais integrados ao editor do Godot permitem gerenciar sistemas complexos sem escrever código manual. O `CafePanel` unifica gerenciamento de áudio, máquinas de estado e visualização de dados.

---

## Plugins da Suíte

### CoreEngine
[![CoreEngine](https://img.shields.io/badge/CoreEngine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Núcleo da CafeEngine, fornecendo as bases para todos os outros plugins.  

> [Mais sobre o CoreEngine](addons/core_engine/README.md)

### AudioManager
[![AudioManager](https://img.shields.io/badge/AudioManager-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Gerencia áudio de forma robusta, transformando pastas de arquivos em `AudioStreamPlaylist`s, `AudioStreamRandomizer`s e outros `Resources` prontos para uso.  

> [Mais sobre o AudioManager](addons/audio_manager/README.md)

### StateMachine
[![StateMachine](https://img.shields.io/badge/StateMachine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Framework de Máquina de Estados paralela e em camadas para IA, personagens e fluxo de jogo, utilizando `StateBehavior` resources.  

> [Mais sobre o StateMachine](addons/state_machine/README.md)

### DataBehavior
[![DataBehavior](https://img.shields.io/badge/DataBehavior-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Gerencia e estrutura dados de jogo de forma modular e reutilizável através de Resources.  

> [Mais sobre o DataBehavior](addons/data_behavior/README.md)

---

## Contribuição

Este projeto é open-source e contribuições são bem-vindas. Consulte nosso [guia de contribuição](CONTRIBUTING.md) para saber como ajudar. Para visualizar o futuro da suíte, veja nosso [Roadmap](roadmap.md).

---

## Licença

Distribuído sob a Licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
