# CafeEngine - Conceito de BottomPanel

Na arquitetura da CafeEngine, um **BottomPanel** é um tipo de painel de interface do usuário que se ancora na parte inferior da janela do editor Godot. Ele é projetado para abrigar funcionalidades que fornecem informações detalhadas, listas de gerenciamento ou ferramentas que podem ser expandidas e recolhidas conforme a necessidade do usuário.

## Características e Propósito

*   **Posicionamento:** Localizado na parte inferior do editor, compartilhando espaço com outras abas padrão do Godot (como "Saída", "Depurador", "Áudio").
*   **Intrusividade:** Média. Embora ocupe uma parte considerável da área vertical da tela quando expandido, ele pode ser recolhido para minimizar sua presença, liberando espaço para a área de trabalho principal.
*   **Funcionalidade:** Ideal para:
    *   **Gerenciamento de Listas:** Exibir e interagir com listas de recursos, scripts, logs ou outros itens gerenciáveis (ex: lista de `DataResource`s ou `StateBehavior`s).
    *   **Ferramentas de Gerenciamento:** Oferecer botões para criar, remover, editar ou atualizar itens dentro dessas listas.
    *   **Informações Detalhadas:** Apresentar dados que, embora importantes, não precisam estar constantemente visíveis ou que se beneficiam de um espaço vertical maior para exibição.
    *   **Depuração:** Mostrar logs, erros ou informações de depuração específicas do plugin.
*   **Flexibilidade:** Permite que o usuário controle sua visibilidade e tamanho, adaptando o layout do editor às suas preferências e à tarefa atual.

## Exemplos de Uso na CafeEngine

*   **DataBehavior:** O `DataBottomPanel` é um exemplo de BottomPanel, utilizado para listar e gerenciar `DataResource`s e seus scripts associados, oferecendo botões para criação, remoção e edição.
*   **StateMachine:** O `StateBottomPanel` cumpre um papel similar, permitindo o gerenciamento de `StateBehavior`s e seus scripts, facilitando a organização e acesso aos componentes da máquina de estados.

Em resumo, o BottomPanel é uma solução eficaz para integrar ferramentas de gerenciamento e visualização de dados que requerem mais espaço do que um SidePanel, mas que ainda oferecem a flexibilidade de serem minimizadas para não sobrecarregar a interface do editor.