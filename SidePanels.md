# CafeEngine - Conceito de SidePanel

Na arquitetura da CafeEngine, um **SidePanel** é um tipo de painel de interface do usuário projetado para ser **não intrusivo**, ocupando um espaço lateral discreto no editor Godot. Sua principal característica é oferecer funcionalidades de configuração rápida ou acionamento de ações específicas, sem interromper o fluxo de trabalho principal do usuário.

## Características e Propósito

*   **Não Intrusivo:** Diferente de painéis que ocupam grandes áreas da tela (como TopPanels ou BottomPanels) ou que bloqueiam a interação (ModalPanels), um SidePanel é compacto e se integra de forma orgânica ao layout do editor.
*   **Ocupa Pouco Espaço:** Ideal para configurações rápidas, exibição de status ou botões de ação que não exigem uma interface complexa.
*   **Funcionalidade Focada:** Não é destinado a grandes edições ou funcionalidades complexas. Em vez disso, foca em:
    *   **Configuração de Plugins:** Ajustar parâmetros globais de um plugin (ex: `AudioConfig` do AudioManager).
    *   **Acionamento de Funções:** Botões para gerar recursos (ex: "Gerar Albuns" do AudioManager), atualizar listas ou navegar para documentações.
    *   **Informações Rápidas:** Exibir mensagens de feedback ou status concisos.
*   **Complementar:** Atua como um complemento ao fluxo de trabalho, fornecendo acesso rápido a ferramentas auxiliares sem exigir que o usuário mude de contexto ou abra janelas adicionais.

## Exemplos de Uso na CafeEngine

*   **AudioManager:** O `AudioPanel` é um exemplo perfeito de SidePanel, permitindo configurar caminhos de assets, gerar manifestos de áudio e acessar a documentação, tudo de forma compacta e acessível.
*   **StateMachine / DataBehavior:** Painéis laterais para configurações rápidas ou atalhos para a criação de Resources.

Em resumo, o SidePanel é a escolha ideal quando a funcionalidade precisa estar sempre à mão, mas sem sobrecarregar a interface do editor ou desviar a atenção do desenvolvedor de sua tarefa principal.