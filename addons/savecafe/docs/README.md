# 💾 SaveCafe

[![Godot Asset Library](https://img.shields.io/badge/Godot_Asset_Library-SaveCafe-478cbf?style=for-the-badge&logo=godot-engine)](https://godotengine.org/asset-library/asset/link-to-asset) <!-- Placeholder -->
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

**SaveCafe** é um plugin para Godot 4.x, parte da suíte CafeEngine, focado em gerenciar e estruturar o salvamento e carregamento de jogos de forma modular e reutilizável através de Resources.

## Visão Geral

O SaveCafe estende a filosofia de Programação Orientada a Resources (ROP) da CafeEngine, permitindo que você defina e organize perfis de salvamento complexos (com dados de jogador, progresso de quests, estado do mundo) como Resources. Isso facilita a edição no Inspector do Godot, a reutilização em diferentes partes do seu projeto e a manutenção.

## Principais Funcionalidades

*   **Perfis de Salvamento Orientados a Resources:** Crie, configure e gerencie todos os seus perfis de salvamento como Resources, aproveitando a serialização e a integração nativa do Godot.
*   **Modularidade:** Separe a lógica de salvamento dos comportamentos, permitindo que seus sistemas sejam mais flexíveis e fáceis de modificar.
*   **Edição no Inspector:** Edite e ajuste os detalhes dos seus perfis de salvamento diretamente no Inspector do Godot, sem a necessidade de codificação.
*   **Reutilização:** Compartilhe e reutilize estruturas de dados de salvamento entre diferentes jogos ou modos de jogo.

## Documentação

A documentação completa, com guias detalhados, tutoriais e a referência da API, pode ser encontrada no nosso site oficial:

[https://www.cafegame.dev/cafeengine/savecafe](https://www.cafegame.dev/cafeengine/savecafe)

## Instalação

1.  **AssetLib (Recomendado):**
    *   Procure por "SaveCafe" na Godot Asset Library e instale o plugin.
2.  **Manual (GitHub):**
    *   Baixe o repositório.
    *   Copie a pasta `addons/savecafe` para a pasta `addons/` do seu projeto.

Após a instalação, vá em `Project -> Project Settings -> Plugins` e ative o plugin **SaveCafe**.

## Contribuição

Este é um projeto open-source. Contribuições são bem-venidas! Por favor, leia nosso [guia de contribuição](CONTRIBUTING.md) para saber como reportar bugs, sugerir funcionalidades e submeter pull requests.

## Licença

Este projeto é distribuído sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
