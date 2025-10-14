# Gemini Configuration and Memories

Este documento contém configurações e memórias específicas para o agente Gemini, garantindo uma comunicação e operação eficientes com o usuário Café GameDev.

## Memórias Adicionadas por Gemini

-   A comunicação com o usuário deve ser sempre em português.
-   O usuario odeia Emojis.
-   O usuário se chama Café GameDev.
-   O site do usuário é: https://www.cafegame.dev/

## Contexto do Projeto CafeEngine

A CafeEngine é uma suíte de plugins para Godot 4, construída sobre a filosofia da Programação Orientada a Resources (ROP). Essa abordagem visa criar ferramentas modulares, reutilizáveis e profundamente integradas ao editor do Godot.

### Filosofia Central da CafeEngine: Programação Orientada a Resources (ROP)

A ideia central é tratar o sistema `Resource` do Godot não apenas como contêineres de dados, mas como **objetos de comportamento ativos e inteligentes**. Isso significa:

-   **Lógica Encapsulada:** A lógica de comportamento (por exemplo, estados de IA, álbuns de música, padrões de ataque) é autocontida dentro de um `Resource`, afastando-se de scripts monolíticos.
-   **Máxima Reutilização:** Um mesmo `Resource` de comportamento pode ser configurado de diferentes maneiras no Inspector e reutilizado em múltiplos personagens e sistemas sem duplicação de código.
-   **Design Orientado a Dados:** O "o quê" (lógica e dados dentro do `Resource`) é separado do "como" (o `Node` na cena que executa o comportamento). Isso promove sistemas flexíveis e facilmente modificáveis.
-   **Fluxo de Trabalho "Godot-Native":** Toda a configuração e gerenciamento são realizados diretamente através do FileSystem e do Inspector do Godot, tornando os plugins intuitivos para qualquer desenvolvedor Godot.

### Plugins da Suíte CafeEngine:

-   **AudioManager:** Um sistema robusto de gerenciamento de áudio.
-   **StateMachine:** Um framework de Máquina de Estados Paralela e em Camadas.
-   **DataBehavior:** Gerencia e estrutura dados de jogo de forma modular.
-   **CoreEngine:** Núcleo da CafeEngine, fornecendo as bases para todos os outros plugins.

### Plugin StateMachine: Detalhes

**StateMachine** é um framework avançado para Godot Engine 4.x, projetado para simplificar e aprimorar a criação de lógicas de comportamento complexas. Ele implementa uma arquitetura de **Máquina de Estados Paralela e em Camadas**, onde os comportamentos são encapsulados em `Resource`s reutilizáveis.

**Arquitetura Central do StateMachine:**

1.  **`StateComponent` (O Gerenciador de Comportamentos):** Um `Node` que atua como o motor de execução dentro de uma cena, gerenciando `StateBehavior`s ativos simultaneamente.
2.  **`StateBehavior` (A Sub-Máquina / Domínio Funcional):** Um `Resource` que encapsula a lógica completa de um domínio funcional, atuando como uma máquina de estados autocontida.
3.  **`StateMachine` (O Singleton Autoload):** Um `Node` global que serve como um orquestrador de alto nível, gerenciando o fluxo geral do jogo e observando `StateComponent`s.

**Filosofia de Desenvolvimento do StateMachine:** A arquitetura do StateMachine enfatiza que os recursos `StateBehavior` não são apenas contêineres de dados. Eles são objetos inteligentes com sua própria lógica, estado interno e a capacidade de emitir sinais para comunicar suas intenções.

**Compatibilidade:** Destinado ao **Godot 4.5** e versões futuras. Nenhuma compatibilidade retroativa com versões anteriores do Godot está planejada.
