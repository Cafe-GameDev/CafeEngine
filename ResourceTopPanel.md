# Planejamento do `CoreTopPanel` (Editor de Resources)

## Objetivo
Criar um painel de editor de alto nível no Godot, acessível como uma aba principal (similar a "2D", "3D", "Script"), dedicado à visualização e edição de arquivos `.tres` como texto/código. Este painel será agnóstico a plugins específicos, servindo como um editor de Resources universal.

**Nome do Painel:** "Resources" (ou "Resource Editor")
**Plugin Responsável:** `ResourceEditor`

## 1. Estrutura da Cena (`addons/core_engine/panel/resource_top_panel.tscn`)

O `CoreTopPanel` será um `Control` que conterá a seguinte hierarquia de nós:

```
CoreTopPanel (Control)
└── HSplitContainer (main_split)
    ├── VSplitContainer (left_panel_split)
    │   ├── VBoxContainer (resource_list_container)
    │   │   ├── HBoxContainer (resource_list_header)
    │   │   │   ├── Label (resource_list_label) - Texto: "Resources"
    │   │   │   └── Button (refresh_button) - Ícone: refresh-cw.svg
    │   │   ├── LineEdit (resource_filter_line_edit) - Para filtrar resources
    │   │   └── ItemList (resource_item_list) - Lista de todos os .tres
    │   └── VBoxContainer (methods_list_container)
    │       ├── HBoxContainer (methods_list_header)
    │       │   ├── Label (methods_list_label) - Texto: "Methods/Properties"
    │       │   └── Button (add_method_button) - Ícone: plus.svg (futuro)
    │       └── ItemList (methods_item_list) - Lista de métodos/propriedades do resource selecionado
    └── VBoxContainer (editor_area)
        ├── HBoxContainer (editor_tabs_container)
        │   └── TabContainer (resource_tab_container) - Abas para resources abertos
        │       └── (Conteúdo das abas será TextEdit)
        └── HBoxContainer (status_bar)
            ├── Label (status_label) - Exibe status (salvo, modificado, etc.)
            └── Button (save_button) - Ícone: save.svg
```

## 2. Funcionalidades do Script (`addons/core_engine/panel/resource_top_panel.gd`)

*   **Inicialização (`_ready`):**
    *   Conectar sinais dos botões (`refresh_button`, `save_button`).
    *   Conectar sinal `text_changed` do `resource_filter_line_edit`.
    *   Conectar sinal `item_activated` do `resource_item_list` para abrir o resource.
    *   Chamar `_populate_resource_list()` para carregar a lista inicial.
    *   (Futuro) Carregar resources abertos anteriormente no `resource_tab_container`.
*   **Listagem de Resources (`_populate_resource_list()`):**
    *   Escaneia recursivamente o diretório `res://` em busca de todos os arquivos `.tres`.
    *   Filtra a lista com base no texto digitado no `resource_filter_line_edit`.
    *   Popula o `resource_item_list` com os caminhos dos arquivos.
*   **Abertura de Resources (`_open_resource_in_editor(path: String)`):**
    *   Verifica se o resource já está aberto em uma aba. Se sim, foca nessa aba.
    *   Cria um novo `TextEdit` para o resource.
    *   Carrega o conteúdo do arquivo `.tres` como texto e o define no `TextEdit`.
    *   Adiciona o `TextEdit` como uma nova aba no `resource_tab_container`.
    *   Conecta o sinal `text_changed` do `TextEdit` para marcar a aba como modificada.
*   **Edição e Salvamento:**
    *   O `TextEdit` permitirá a edição direta do conteúdo do `.tres`.
    *   O `save_button` salvará o conteúdo do `TextEdit` da aba ativa de volta para o arquivo `.tres` correspondente.
    *   Um indicador visual (ex: `*` no título da aba) mostrará se o resource foi modificado e não salvo.
*   **Lista de Métodos/Propriedades (`methods_item_list`):**
    *   Ao selecionar um item na `resource_item_list`, este painel será populado.
    *   Para `Resource`s com scripts anexados, listará as propriedades `@export` e métodos definidos no script.
    *   Para `Resource`s sem script, listará as propriedades exportadas do `Resource` base.
*   **Navegação:**
    *   Duplo clique em um item na `resource_item_list` abrirá o resource no editor.
    *   (Futuro) Duplo clique em um item na `methods_item_list` poderá navegar para a linha correspondente no `TextEdit`.

## 3. Integração com `addons/core_engine/scripts/editor_plugin.gd`

*   No método `_enter_tree()` do `editor_plugin.gd` do ResourceEditor, será adicionada uma nova função `_create_top_panel()`.
*   Esta função instanciará `resource_top_panel.tscn` e o adicionará ao editor Godot como uma nova aba principal, usando `add_control_to_container(MAIN_SCREEN_CONTAINER, top_panel_instance)`.
*   O texto do botão da aba será definido como "Resources" usando `set_main_screen_button_text(top_panel_instance, "Resources")`.
*   No método `_exit_tree()`, o `CoreTopPanel` será removido e liberado.

## 4. Ícones

*   `refresh-cw.svg`: Já existe no `audio_manager/icons`, pode ser reutilizado.
*   `plus.svg`: Será necessário criar ou encontrar um ícone para "adicionar método/propriedade" (futuro).
*   `save.svg`: Será necessário criar ou encontrar um ícone para "salvar".
