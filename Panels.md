# CafeEngine - Tipos de Painéis no Editor Godot

Na CafeEngine, a interação com o editor Godot é aprimorada através de diferentes tipos de painéis, cada um com um propósito e nível de intrusividade específicos. Compreender essas distinções é crucial para manter a ergonomia e a eficiência do fluxo de trabalho.

## 1. SidePanel

*   **Propósito:** Painéis não intrusivos, compactos e laterais, projetados para configurações rápidas, exibição de status concisos ou acionamento de funções auxiliares. O `ResourcePanel` é o host unificado para todos os SidePanels dos plugins da CafeEngine.
*   **Intrusividade:** Baixa. Ocupa pouco espaço e não interfere significativamente na área de trabalho principal.
*   **Funcionalidade:** Focada em ações pontuais ou ajustes de parâmetros de plugins. Não é ideal para edições complexas ou visualizações extensas.
*   **Exemplos:** O `AudioPanel` do AudioManager (para configurações e geração de áudio), o `DataPanel` do DataBehavior e o `StateSidePanel` do StateMachine (ambos principalmente para acesso rápido à documentação e configurações gerais).

## 2. TopPanel

*   **Propósito:** Painéis de alto nível que ocupam uma aba principal do editor (similar a "2D", "3D", "Script"). Destinados a funcionalidades que exigem uma área de trabalho dedicada e ampla.
*   **Intrusividade:** Média a Alta. Redireciona o foco do usuário para uma nova "tela" dentro do editor.
*   **Funcionalidade:** Ideal para editores visuais complexos, gerenciamento de grandes coleções de recursos ou ferramentas que se beneficiam de um espaço de tela generoso.
*   **Exemplos:** O `ResourceTopPanel` (Editor de Resources) da ResourceEditor, que oferece um editor de texto universal para Resources, e o `BlueprintTopPanel` (Editor Visual de Lógica) do BlueprintEditor, que permite a construção de lógica baseada em grafos.

## 3. BottomPanel

*   **Propósito:** Painéis que se ancoram na parte inferior do editor, geralmente usados para exibir logs, listas de itens, ou ferramentas de gerenciamento que podem ser expandidas/colapsadas.
*   **Intrusividade:** Média. Ocupa uma parte considerável da área vertical da tela, mas pode ser minimizado.
*   **Funcionalidade:** Adequado para gerenciamento de listas de recursos, scripts, ou para exibir informações detalhadas que não precisam estar visíveis o tempo todo. É o local principal para a interação com as funcionalidades de gerenciamento de `DataResource`s (via `DataBottomPanel`) e `StateBehavior`s (via `StateBottomPanel`).
*   **Exemplos:** O `DataBottomPanel` do DataBehavior, `StateBottomPanel` do StateMachine.

## Conclusão

A escolha do tipo de painel adequado é fundamental para a usabilidade de um plugin. A CafeEngine busca utilizar cada tipo de painel de forma estratégica, garantindo que as ferramentas sejam poderosas e eficientes, mas sempre com a melhor experiência de usuário em mente.