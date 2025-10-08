# CafeEngine - Plugin Design Document (PDD) Geral

**Versão do Documento:** 1.0
**Data:** 2025-10-08
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia da Suíte CafeEngine

### 1.1. Conceito

A **CafeEngine** é uma suíte de plugins para Godot Engine 4.x, projetada para fornecer um conjunto robusto e modular de ferramentas para o desenvolvimento de jogos. Cada plugin dentro da suíte aborda um domínio específico (áudio, estados, dados, etc.), mas todos compartilham uma filosofia central e uma arquitetura consistente, visando maximizar a reutilização, a modularidade e a integração nativa com o editor Godot.

### 1.2. Filosofia Central: Programação Orientada a Resources (ROP)

A pedra angular da CafeEngine é a **Programação Orientada a Resources (ROP)**. Acreditamos que o sistema de `Resource` do Godot é uma ferramenta poderosa e muitas vezes subutilizada. Nossa filosofia é tratar os `Resources` não apenas como contêineres de dados passivos, mas como **objetos de comportamento ativos e inteligentes**.

Isso implica que:

-   **Lógica Encapsulada:** A lógica de comportamento (seja um estado de IA, uma configuração de áudio, uma receita de crafting) é autocontida dentro de um `Resource`. Isso evita scripts monolíticos e promove a coesão.
-   **Máxima Reutilização:** Um mesmo `Resource` de comportamento pode ser configurado de diferentes maneiras no Inspector e reutilizado em múltiplos personagens, sistemas ou projetos sem duplicação de código.
-   **Design Orientado a Dados:** Há uma separação clara entre o **"o quê"** (a lógica e os dados dentro do `Resource`) e o **"como"** (o `Node` na cena que executa ou interage com aquele comportamento). Isso resulta em sistemas flexíveis e facilmente modificáveis.
-   **Fluxo de Trabalho "Godot-Native":** Toda a configuração, edição e gerenciamento são realizados diretamente através do FileSystem e do Inspector do Godot, tornando os plugins intuitivos para qualquer desenvolvedor Godot.
-   **Resources Ativos e Reativos:** Os `Resources` podem possuir métodos, propriedades e, crucialmente, **sinais**. Eles podem emitir eventos para comunicar suas intenções ou mudanças de estado, permitindo uma arquitetura reativa e desacoplada.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** A suíte CafeEngine e todos os seus plugins têm como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** Os projetos serão ativamente mantidos para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Central da Suíte

A suíte CafeEngine adota uma arquitetura modular e extensível, onde cada plugin se integra de forma coesa ao ambiente do editor Godot e ao runtime do jogo.

### 2.1. Componentes Comuns a Todos os Plugins

Cada plugin da CafeEngine geralmente é composto pelos seguintes elementos:

-   **`[PluginName]Manager` (Autoload Singleton):** Um `Node` global que atua como o ponto de acesso central para as funcionalidades do plugin em runtime. Ele gerencia os `Resources` específicos do plugin, orquestra operações e emite sinais globais.
-   **`[PluginName]Config` (Resource):** Um `Resource` que armazena as configurações e preferências do plugin, persistindo-as entre sessões do editor. Ele emite um sinal (`config_changed`) quando suas propriedades são modificadas, permitindo que a UI do plugin reaja dinamicamente.
-   **`[Domain]Data` (Resource Base):** Uma classe `Resource` abstrata (ou base) que define a estrutura fundamental para os dados ou comportamentos gerenciados pelo plugin (ex: `StateBehavior`, `ItemData`, `AudioConfig`). Outros `Resources` específicos herdam desta base.
-   **`EditorPlugin` (`editor_plugin.gd`):** O script principal que integra o plugin ao editor Godot. Ele é responsável por:
    -   Adicionar o `[PluginName]Manager` como um Autoload Singleton (se aplicável).
    -   Registrar `Custom Types` para os `Resources` do plugin, tornando-os visíveis e criáveis no menu "Create Resource" do FileSystem.
    -   Integrar a UI do plugin ao `CafePanel` (descrito abaixo).
-   **`[PluginName]Panel` (UI do Editor):** Um `Control` (geralmente um `VBoxContainer`) que fornece a interface gráfica do plugin dentro do editor Godot. Ele permite configurar o plugin, visualizar `Resources` e interagir com suas funcionalidades.

### 2.2. O `CafePanel` (Host Unificado da UI)

Para manter a organização e evitar a poluição da interface do editor, todos os `[PluginName]Panel`s dos plugins da CafeEngine são hospedados dentro de um único `ScrollContainer` chamado **`CafePanel`**. Este `CafePanel` é adicionado a um dock lateral do editor e atua como um contêiner para todos os painéis individuais dos plugins.

-   **Vantagens:**
    -   **Organização:** Todos os plugins da suíte são acessíveis em um único local no editor.
    -   **Consistência:** Padroniza a forma como os plugins são apresentados e interagidos.
    -   **Modularidade:** Cada plugin pode ser ativado/desativado independentemente, e seu painel será adicionado/removido dinamicamente do `CafePanel`.

---

## 3. Estrutura de Arquivos Padrão para Plugins

Para garantir consistência e facilitar a manutenção, todos os plugins da CafeEngine devem seguir uma estrutura de pastas padrão:

```
addons/[plugin_name]/
├── plugin.cfg
├── components/             # Scripts e cenas de nós (Nodes) do plugin (ex: Managers, Components)
│   └── [plugin_name]_manager.gd
├── resources/              # Resources base e pastas para Resources específicos
│   ├── [plugin_name]_config.tres
│   └── [domain_name]s/     # Ex: behaviors/, item_data/, quest_data/
│       ├── [domain_name]_data.gd
│       └── [specific_resource].gd
├── panel/                  # Cenas e scripts da UI do editor
│   ├── [plugin_name]_panel.gd
│   └── [plugin_name]_panel.tscn
├── scripts/                # Scripts de editor e utilitários
│   └── editor_plugin.gd
├── icons/                  # Ícones para Custom Types e UI do editor
│   └── [plugin_name]_icon.svg
├── docs/                   # Documentação específica do plugin (README.md, plugin_design_document.md)
│   └── README.md
│   └── plugin_design_document.md
├── .github/                # Templates de Issues e PRs específicos do plugin
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

---

## 4. Plano de Desenvolvimento em Fases (Visão Geral da Suíte)

O desenvolvimento da suíte CafeEngine segue uma abordagem iterativa e modular, com cada plugin progredindo através de fases semelhantes:

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   **Foco:** Estabelecer as classes base (`Resource`s e `Node`s) e a lógica essencial do plugin.
-   **Resultado:** Um sistema funcional que demonstra a filosofia ROP para o domínio específico do plugin, com testes básicos e um demo inicial.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   **Foco:** Integrar o sistema ao editor Godot como um plugin oficial.
-   **Resultado:** `plugin.cfg` configurado, `EditorPlugin` funcional, `Custom Types` registrados e propriedades organizadas no Inspector com categorias (`_get_property_list()`).

### Fase 3: Expansão da Biblioteca e Controles Customizados

-   **Foco:** Desenvolver uma biblioteca mais rica de `Resources` e funcionalidades para o plugin, além de aprimorar a experiência do editor.
-   **Resultado:** Mais `[Domain]Data`s implementados, e, se aplicável, `EditorInspectorPlugin`s para controles customizados e validações visuais no Inspector.

### Fase 4: Painel de UI e Ferramentas de Depuração

-   **Foco:** Criar a interface gráfica completa do plugin no editor para visualização, gerenciamento e depuração.
-   **Resultado:** `[PluginName]Panel` funcional, com ferramentas para criar, editar e testar os `Resources` do plugin, e feedback visual em tempo real.

### Fase 5: Documentação e Exemplos

-   **Foco:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.
-   **Resultado:** Código bem documentado, guias externos (`docs/` do plugin) e um projeto demo completo que ilustra o uso do plugin.

---

## 5. Considerações Futuras (Pós-MVP da Suíte)

À medida que os plugins individuais amadurecem, a CafeEngine buscará aprimoramentos e integrações em nível de suíte:

-   **Integração Cruzada entre Plugins:** Desenvolver sinergias e comunicação direta entre os plugins (ex: `StateCafe` usando `DataCafe` para parâmetros de estado, `AudioCafe` disparando eventos do `EventCafe`).
-   **Editor Visual Unificado:** Explorar a criação de um editor visual mais abrangente que possa orquestrar múltiplos plugins (ex: um editor de grafos que combine estados, eventos e diálogos).
-   **Ferramentas de Geração de Código/Resources:** Automatizar ainda mais a criação de `Resources` e scripts base a partir de templates ou interfaces visuais.
-   **Otimização e Performance:** Implementar pooling de objetos, carregamento assíncrono e outras técnicas para garantir a alta performance da suíte em projetos complexos.

Este documento serve como um guia para o desenvolvimento consistente e alinhado com a visão da CafeEngine, garantindo que cada plugin contribua para um ecossistema coeso e poderoso para desenvolvedores Godot.