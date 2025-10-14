# Configuration and Memories

Este documento contém configurações e memórias específicas para o agente, garantindo uma comunicação e operação eficientes com o usuário Café GameDev.

## Memórias Adicionadas

-   A comunicação com o usuário deve ser sempre em português.
-   O usuario odeia Emojis.
-   O usuário se chama Café GameDev.
-   O site do usuário é: https://www.cafegame.dev/
-   Sempre que receber uma url, faça webfetch nela

## Metodologia de Trabalho

Para garantir uma colaboração eficiente e segura, o agente seguirá rigorosamente a seguinte metodologia ao abordar qualquer tarefa:

1.  **Análise Detalhada:** Antes de qualquer ação, será realizada uma análise aprofundada da solicitação do usuário e do contexto relevante do projeto. Isso inclui a leitura de arquivos, busca por padrões e compreensão das convenções existentes.
2.  **Elaboração do Plano:** Com base na análise, será formulado um plano de ação claro e conciso, detalhando os passos a serem seguidos para cumprir a tarefa.
3.  **Apresentação do Plano:** O plano será apresentado ao usuário para revisão.
4.  **Autorização Expressa:** A implementação do plano só será iniciada após a **autorização expressa** do usuário. Nenhuma modificação ou execução de código será realizada sem essa permissão explícita.

## Contexto do Projeto CafeEngine

A CafeEngine é uma suíte de plugins para Godot 4, construída sobre a filosofia da Programação Orientada a Resources (ROP). Essa abordagem visa criar ferramentas modulares, reutilizáveis e profundamente integradas ao editor do Godot.

### Filosofia Central da CafeEngine: Programação Orientada a Resources (ROP)

A ideia central é tratar o sistema `Resource` do Godot não apenas como contêineres de dados, mas como **objetos de comportamento ativos e inteligentes**. Isso significa:

-   **Lógica Encapsulada:** A lógica de comportamento (por exemplo, estados de IA, álbuns de música, padrões de ataque) é autocontida dentro de um `Resource`, afastando-se de scripts monolíticos.
-   **Máxima Reutilização:** Um mesmo `Resource` de comportamento pode ser configurado de diferentes maneiras no Inspector e reutilizado em múltiplos personagens e sistemas sem duplicação de código.
-   **Design Orientado a Dados:** O "o quê" (lógica e dados dentro do `Resource`) é separado do "como" (o `Node` na cena que executa o comportamento). Isso promove sistemas flexíveis e facilmente modificáveis.
-   **Fluxo de Trabalho "Godot-Native":** Toda a configuração e gerenciamento são realizados diretamente através do FileSystem e do Inspector do Godot, tornando os plugins intuitivos para qualquer desenvolvedor Godot.

### Metodologia de Plugin Design Document (PDD)

A CafeEngine adota uma metodologia de Plugin Design Document (PDD) para garantir a consistência, modularidade e interoperabilidade entre todos os plugins da suíte. Cada PDD detalha a visão, filosofia, arquitetura, estrutura de arquivos, plano de desenvolvimento em fases, padrões de qualidade de código e considerações futuras para um plugin específico.

-   **Visão Geral e Filosofia:** Define o conceito e os princípios fundamentais do plugin.
-   **Arquitetura Central:** Descreve os componentes principais e como eles interagem.
-   **Estrutura de Arquivos Padrão:** Garante consistência e facilita a navegação.
-   **Plano de Desenvolvimento em Fases:** Detalha os objetivos e resultados de cada fase.
-   **Padrões de Qualidade de Código:** Assegura a legibilidade e manutenibilidade.

### Tipos de Painéis no Editor Godot

A interação com o editor Godot na CafeEngine é aprimorada através de diferentes tipos de painéis, cada um com um propósito e nível de intrusividade específicos:

-   **SidePanel:** Painéis não intrusivos, compactos e laterais, ideais para configurações rápidas, exibição de status concisos ou acionamento de funções auxiliares. O `CorePanel` é o host unificado para todos os SidePanels dos plugins da CafeEngine.
-   **TopPanel:** Painéis de alto nível que ocupam uma aba principal do editor (similar a "2D", "3D", "Script"), destinados a funcionalidades que exigem uma área de trabalho dedicada e ampla. Ex: `CoreTopPanel` (Editor de Resources).
-   **BottomPanel:** Painéis que se ancoram na parte inferior do editor, geralmente usados para exibir logs, listas de itens ou ferramentas de gerenciamento que podem ser expandidas/colapsadas. Ex: `DataBottomPanel`, `StateBottomPanel`.
-   **ModalPanel:** Janelas pop-up que bloqueiam a interação com o restante do editor até serem fechadas, usadas para tarefas que exigem atenção total do usuário ou para coletar informações específicas. Ex: `DataModalPanel`, `StateModalPanel`.

### Integração e Features Cross-Plugin

A força da CafeEngine reside na sua capacidade de orquestrar múltiplos plugins de forma coesa, permitindo que eles se relacionem e colaborem para criar sistemas de jogo complexos. A integração entre plugins é guiada pelos princípios de desacoplamento, reatividade e orientação a Resources (ROP).

-   **Mecanismos de Comunicação:**
    -   **Sinais (Signals):** Principal mecanismo para comunicação reativa, onde um plugin emite um sinal e outros podem se conectar para reagir.
    -   **Autoloads (Singletons Globais):** Plugins como `StateMachine` e `AudioManager` são Autoloads, tornando-os acessíveis globalmente para interações de alto nível.
    -   **Resources Compartilhados:** Resources definidos por um plugin podem ser referenciados e utilizados por outro, atuando como "contratos" de dados e comportamento.
-   **Diretrizes:** Definir contratos claros, documentar a integração, evitar acoplamento forte e usar o `CoreEngine` como mediador.

### Plugins da Suíte CafeEngine:

-   **AudioManager:** Um sistema robusto de gerenciamento de áudio.
-   **StateMachine:** Um framework de Máquina de Estados Paralela e em Camadas.
-   **DataBehavior:** Gerencia e estrutura dados de jogo de forma modular.
-   **CoreEngine:** Núcleo da CafeEngine, fornecendo as bases para todos os outros plugins.

