# ☕ CafeEngine Suite

[![CafeEngine](https://img.shields.io/badge/CafeEngine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

**CafeEngine** é uma suíte de plugins para Godot 4, construída com uma filosofia de **Programação Orientada a Resources** para criar ferramentas modulares, reutilizáveis e profundamente integradas ao editor.

---
## WorkFlow

O principal objetivo da CafeEngine não é adicionar funcionalidades impossíveis de se criar no Godot, mas sim **otimizar radicalmente o fluxo de trabalho (workflow)** do desenvolvedor. Tudo o que nossos plugins oferecem poderia ser feito manualmente, mas exigiria tempo, código repetitivo e organização manual.

Nossa filosofia é fornecer uma **camada de qualidade de vida** sobre a engine, oferecendo um caminho estruturado, visual e produtivo para tarefas comuns. A CafeEngine se baseia na sinergia de cinco pilares que, juntos, permitem que você se concentre no design do seu jogo, e não na configuração.

### 1. Programação Orientada a Resources (ROP)

Este é o coração da nossa filosofia. Tratamos `Resources` não como meros contêineres de dados, mas como **objetos de comportamento ativos e inteligentes**. A lógica de um comportamento (um estado de IA, um padrão de ataque, um perfil de áudio) é encapsulada diretamente no `Resource`, tornando-o reutilizável e configurável pelo Inspector.

> Para uma imersão profunda, leia nosso manifesto sobre [Programação Orientada a Resources (ROP)](ROP.md).

### 2. Blueprints

No ecossistema CafeEngine, os `Resources` atuam como **Blueprints**. Um `StateBehavior`, por exemplo, não é apenas um estado, mas um modelo de comportamento que pode ser instanciado e configurado de inúmeras maneiras. Um `WeaponData` é um blueprint para uma arma, contendo todos os seus atributos. Isso permite que desenvolvedores e designers criem variações complexas sem escrever uma linha de código.

### 3. Autoloads / Custom Types (Nodes)

Se os `Resources` (Blueprints) definem **"o quê"** fazer, os `Nodes` definem **"como"** e **"onde"** fazer.
-   **Autoloads (Managers):** São os orquestradores globais. O `StateMachine` gerencia o fluxo do jogo, enquanto o `AudioManager` controla o áudio. Eles são o cérebro central que coordena os sistemas.
-   **Custom Types (Components):** São os executores na cena. Um `StateComponent` é um `Node` que você adiciona a um personagem para rodar a lógica definida nos `StateBehavior`s. Eles são a ponte entre a cena e os Blueprints.

### 4. Panels / Editors

São as **ferramentas visuais** que unem tudo. Em vez de configurar sistemas complexos via código, você usa painéis integrados ao editor do Godot. O `CafePanel` é o nosso dock unificado, onde você pode gerenciar áudio, criar máquinas de estado, e visualizar dados de forma intuitiva. Eles são a interface que torna o poder dos outros pilares acessível e fácil de usar.

---

## Plugins da Suíte

### ⚙️ CoreEngine

[![CoreEngine](https://img.shields.io/badge/CoreEngine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Nucleo do CafeEngine

> [Saiba mais sobre o CoreEngine...](addons/core_engine/README.md)

### 🎵 AudioManager

[![AudioManager](https://img.shields.io/badge/AudioManager-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Um sistema de gerenciamento de áudio robusto que transforma pastas de arquivos de som em `AudioStreamPlaylist`s, `AudioStreamRandomizer`s e outros `Resource`s de áudio dinâmicos, prontos para uso e exportação.

> [Saiba mais sobre o AudioManager...](addons/audio_manager/README.md)

### 🧠 StateMachine

[![StateMachine](https://img.shields.io/badge/StateMachine-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Um framework de Máquina de Estados Paralela e em Camadas que permite construir lógicas complexas de IA, personagens e fluxo de jogo de forma modular e visual, utilizando `StateBehavior` resources.

> [Saiba mais sobre o StateMachine...](addons/state_machine/README.md)

### 📊 DataBehavior

[![DataBehavior](https://img.shields.io/badge/DataBehavior-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

Um plugin para Godot 4.x, parte da suíte CafeEngine, focado em gerenciar e estruturar dados de jogo de forma modular e reutilizável através de Resources.

> [Saiba mais sobre o DataBehavior...](addons/data_behavior/README.md)

---

## Contribuição

Este é um projeto open-source e contribuições são muito bem-vindas. Para saber como ajudar, por favor, leia nosso [guia de contribuição](CONTRIBUTING.md).

Para ter uma visão geral do futuro da suíte e dos planos de desenvolvimento, consulte nosso [Roadmap](roadmap.md).

## Licença

Distribuído sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
