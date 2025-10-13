# ☕ CafeEngine Suite

[![Godot Asset Library](https://img.shields.io/badge/Godot_Asset_Library-CafeEngine-478cbf?style=for-the-badge&logo=godot-engine)](https://godotengine.org/asset-library/asset/link-to-asset) <!-- Placeholder -->
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

**CafeEngine** é uma suíte de plugins para Godot 4, construída com uma filosofia de **Programação Orientada a Resources** para criar ferramentas modulares, reutilizáveis e profundamente integradas ao editor.

---

## Nossa Filosofia: Programação Orientada a Resources (ROP)

Acreditamos que o sistema de `Resource` do Godot é uma de suas ferramentas mais poderosas, e muitas vezes subutilizada. A filosofia por trás de todos os plugins da CafeEngine é tratar `Resources` não como meros contêineres de dados, mas como **objetos de comportamento ativos e inteligentes**.

Para uma compreensão mais aprofundada da nossa filosofia de design, consulte o documento completo sobre [Programação Orientada a Resources (ROP)](ROP.md).

Em resumo, isso significa que:

-   **Lógica é Encapsulada:** Em vez de scripts monolíticos, a lógica de um comportamento (seja um estado de IA, um álbum de música ou um padrão de ataque) é autocontida dentro de um `Resource`.
-   **Reutilização Máxima:** Um mesmo `Resource` de comportamento pode ser configurado de maneiras diferentes no Inspector e reutilizado por múltiplos personagens e sistemas, sem duplicação de código.
-   **Design Orientado a Dados:** Separamos o **"o quê"** (a lógica e os dados dentro do `Resource`) do **"como"** (o `Node` na cena que executa aquele comportamento). Isso torna os sistemas incrivelmente flexíveis e fáceis de modificar.
-   **Fluxo de Trabalho "Godot-Native":** Toda a configuração e gerenciamento são feitos através do FileSystem e do Inspector, tornando o uso dos plugins intuitivo para qualquer desenvolvedor Godot.

---

## Plugins da Suíte

### 🎵 AudioManager

Um sistema de gerenciamento de áudio robusto que transforma pastas de arquivos de som em `AudioStreamPlaylist`s, `AudioStreamRandomizer`s e outros `Resource`s de áudio dinâmicos, prontos para uso e exportação.

> [Saiba mais sobre o AudioManager...](addons/audiocafe/README.md)

### 🧠 StateMachine

Um framework de Máquina de Estados Paralela e em Camadas que permite construir lógicas complexas de IA, personagens e fluxo de jogo de forma modular e visual, utilizando `StateBehavior` resources.

> [Saiba mais sobre o StateMachine...](addons/statecafe/README.md)

### 📊 DataBehavior

Um plugin para Godot 4.x, parte da suíte CafeEngine, focado em gerenciar e estruturar dados de jogo de forma modular e reutilizável através de Resources.

> [Saiba mais sobre o DataBehavior...](addons/datacafe/README.md)

---

## Contribuição

Este é um projeto open-source e contribuições são muito bem-vindas. Para saber como ajudar, por favor, leia nosso [guia de contribuição](CONTRIBUTING.md).

Para ter uma visão geral do futuro da suíte e dos planos de desenvolvimento, consulte nosso [Roadmap](roadmap.md).

## Licença

Distribuído sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
