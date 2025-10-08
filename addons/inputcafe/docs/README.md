# ⌨️ InputCafe

[![Godot Asset Library](https://img.shields.io/badge/Godot_Asset_Library-InputCafe-478cbf?style=for-the-badge&logo=godot-engine)](https://godotengine.org/asset-library/asset/link-to-asset) <!-- Placeholder -->
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

**InputCafe** é um plugin para Godot 4.x, parte da suíte CafeEngine, focado em gerenciar e estruturar inputs e mapeamentos de forma modular e reutilizável através de Resources.

## Visão Geral

O InputCafe estende a filosofia de Programação Orientada a Resources (ROP) da CafeEngine, permitindo que você defina e organize perfis de input complexos (como mapeamentos de teclado, gamepad, sensibilidade do mouse) como Resources. Isso facilita a edição no Inspector do Godot, a reutilização em diferentes partes do seu projeto e a manutenção.

## Principais Funcionalidades

*   **Perfis de Input Orientados a Resources:** Crie, configure e gerencie todos os seus perfis de input como Resources, aproveitando a serialização e a integração nativa do Godot.
*   **Modularidade:** Separe a lógica de input dos comportamentos, permitindo que seus sistemas sejam mais flexíveis e fáceis de modificar.
*   **Edição no Inspector:** Edite e ajuste os valores dos seus inputs diretamente no Inspector do Godot, sem a necessidade de codificação.
*   **Reutilização:** Compartilhe e reutilize conjuntos de inputs entre diferentes entidades e sistemas do jogo.

## Documentação

A documentação completa, com guias detalhados, tutoriais e a referência da API, pode ser encontrada no nosso site oficial:

[https://www.cafegame.dev/cafeengine/inputcafe](https://www.cafegame.dev/cafeengine/inputcafe)

## Instalação

1.  **AssetLib (Recomendado):**
    *   Procure por "InputCafe" na Godot Asset Library e instale o plugin.
2.  **Manual (GitHub):**
    *   Baixe o repositório.
    *   Copie a pasta `addons/inputcafe` para a pasta `addons/` do seu projeto.

Após a instalação, vá em `Project -> Project Settings -> Plugins` e ative o plugin **InputCafe**.

## Contribuição

Este é um projeto open-source. Contribuições são bem-vindas! Por favor, leia nosso [guia de contribuição](CONTRIBUTING.md) para saber como reportar bugs, sugerir funcionalidades e submeter pull requests.

## Licença

Este projeto é distribuído sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
