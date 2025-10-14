# CafeEngine - Tipos de Painéis no Editor Godot

Na CafeEngine, a interação com o editor Godot é aprimorada através de diferentes tipos de painéis, cada um com um propósito e nível de intrusividade específicos. Compreender essas distinções é crucial para manter a ergonomia e a eficiência do fluxo de trabalho.

## 1. SidePanel

*   **Propósito:** Painéis não intrusivos, compactos e laterais, projetados para configurações rápidas, exibição de status concisos ou acionamento de funções auxiliares.
*   **Intrusividade:** Baixa. Ocupa pouco espaço e não interfere significativamente na área de trabalho principal.
*   **Funcionalidade:** Focada em ações pontuais ou ajustes de parâmetros de plugins. Não é ideal para edições complexas ou visualizações extensas.
*   **Exemplos:** O `AudioPanel` do AudioManager, `StateSidePanel` do StateMachine.

## 2. TopPanel

*   **Propósito:** Painéis de alto nível que ocupam uma aba principal do editor (similar a "2D", "3D", "Script"). Destinados a funcionalidades que exigem uma área de trabalho dedicada e ampla.
*   **Intrusividade:** Média a Alta. Redireciona o foco do usuário para uma nova "tela" dentro do editor.
*   **Funcionalidade:** Ideal para editores visuais complexos, gerenciamento de grandes coleções de recursos ou ferramentas que se beneficiam de um espaço de tela generoso.
*   **Exemplos:** O `CoreTopPanel` (Editor de Resources) da CoreEngine.

## 3. BottomPanel

*   **Propósito:** Painéis que se ancoram na parte inferior do editor, geralmente usados para exibir logs, listas de itens, ou ferramentas de gerenciamento que podem ser expandidas/colapsadas.
*   **Intrusividade:** Média. Ocupa uma parte considerável da área vertical da tela, mas pode ser minimizado.
*   **Funcionalidade:** Adequado para gerenciamento de listas de recursos, scripts, ou para exibir informações detalhadas que não precisam estar visíveis o tempo todo.
*   **Exemplos:** O `DataBottomPanel` do DataBehavior, `StateBottomPanel` do StateMachine.

## 4. ModalPanel

*   **Propósito:** Janelas pop-up que bloqueiam a interação com o restante do editor até serem fechadas. Usadas para tarefas que exigem atenção total do usuário ou para coletar informações específicas.
*   **Intrusividade:** Alta. Interrompe completamente o fluxo de trabalho atual.
*   **Funcionalidade:** Ideal para diálogos de confirmação, formulários de criação de novos recursos, ou editores de propriedades detalhados que precisam de um ambiente isolado.
*   **Exemplos:** O `DataModalPanel` do DataBehavior, `StateModalPanel` do StateMachine.

## Conclusão

A escolha do tipo de painel adequado é fundamental para a usabilidade de um plugin. A CafeEngine busca utilizar cada tipo de painel de forma estratégica, garantindo que as ferramentas sejam poderosas e eficientes, mas sempre com a melhor experiência de usuário em mente.