# InputCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-07
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **InputCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar inputs e mapeamentos de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem perfis de input complexos do seu jogo como Resources.

### 1.2. Filosofia

-   **Inputs como Resources:** Todos os mapeamentos de input (teclado, mouse, gamepad) são tratados como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre inputs e lógica de comportamento, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e desenvolvedores editem e ajustem os mapeamentos de input diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de perfis de input entre diferentes entidades e sistemas do jogo.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O InputCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `InputManager` (O Gerenciador de Inputs)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para todos os perfis de input do jogo. Ele pode carregar, armazenar e fornecer acesso a `InputProfile`s.
-   **Funcionalidades Planejadas:**
    -   Carregamento e ativação de perfis de input.
    -   Alternância entre diferentes perfis (ex: "Controle de Carro", "Controle de Personagem").
    -   (Futuro) Remapeamento de inputs em tempo de execução.

### 2.2. `InputProfile` (A Base para Perfis de Input)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todos os perfis de input específicos do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
-   **Exemplos de Implementação:**
    -   `KeyboardProfile`: Contém mapeamentos de teclas.
    -   `GamepadProfile`: Contém mapeamentos de botões e eixos de gamepad.
    -   `PlayerInputProfile`: Combina mapeamentos de teclado e gamepad para um jogador.

---

## 3. Estrutura de Arquivos Proposta

```
addons/inputcafe/
├── plugin.cfg
├── components/
│   └── input_manager.gd
├── resources/
│   ├── input_config.tres
│   └── input_profiles/ # Subpasta para todos os InputProfiles (recursos)
│       ├── input_profile.gd
│       ├── keyboard_profile.gd
│       └── gamepad_profile.gd
├── panel/
│   ├── input_panel.gd
│   └── input_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── input_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `input_profile.gd` como a classe base para todos os recursos de input.
-   [ ] **Criar `InputManager`:** Implementar `input_manager.gd` como um autoload singleton.
-   [ ] **Criar Perfis de Input de Exemplo:** Desenvolver `KeyboardProfile` e `GamepadProfile` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir e acessar perfis de input através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `InputProfile` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação de `InputProfile`s.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `InputProfile`s para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `input_panel.tscn` e `input_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar os `InputProfile`s carregados.
    -   Ferramentas para criar e editar `InputProfile`s.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de inputs.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversos `InputProfile`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Remapeamento em Tempo de Execução:** Permitir que o jogador remapeie os controles durante o jogo.
-   **Editor Visual de Mapeamentos:** Uma ferramenta visual para criar e gerenciar mapeamentos de input.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `StateCafe` usando `InputProfile` para transições).
