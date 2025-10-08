# AbilityCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-07
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **AbilityCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar habilidades e magias de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem habilidades complexas do seu jogo como Resources.

### 1.2. Filosofia

-   **Habilidades como Resources:** Todas as definições de habilidades (custos, cooldowns, efeitos, animações, requisitos) são tratadas como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre a definição da habilidade e a lógica de jogo que a executa, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e desenvolvedores editem e ajustem os detalhes das habilidades diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de definições de habilidades entre diferentes personagens, classes, inimigos ou itens.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O AbilityCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `AbilitySystem` (O Gerenciador de Habilidades)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para gerenciar o uso de habilidades no jogo. Ele pode carregar, armazenar e fornecer acesso a `AbilityData`s e gerenciar a lógica de ativação, cooldowns e custos.
-   **Funcionalidades Planejadas:**
    -   Ativar e desativar habilidades.
    -   Gerenciar cooldowns e custos (mana, energia).
    -   Emitir sinais para notificar o UI ou outros sistemas sobre o uso de habilidades.

### 2.2. `AbilityData` (A Base para Definições de Habilidades)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todas as definições de habilidades específicas do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
-   **Exemplos de Implementação:**
    -   `MeleeAttackAbility`: Ataques corpo a corpo.
    -   `RangedAttackAbility`: Ataques à distância.
    -   `HealingAbility`: Habilidades de cura.

---

## 3. Estrutura de Arquivos Proposta

```
addons/abilitycafe/
├── plugin.cfg
├── components/
│   └── ability_system.gd
├── resources/
│   ├── ability_config.tres
│   └── ability_data/ # Subpasta para todos os AbilityData (recursos)
│       ├── ability_data.gd
│       ├── melee_attack_ability.gd
│       └── healing_ability.gd
├── panel/
│   ├── ability_panel.gd
│   └── ability_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── ability_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `ability_data.gd` como a classe base para todos os recursos de habilidade.
-   [ ] **Criar `AbilitySystem`:** Implementar `ability_system.gd` como um autoload singleton.
-   [ ] **Criar Definições de Habilidades de Exemplo:** Desenvolver `MeleeAttackAbility` e `HealingAbility` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir e gerenciar habilidades através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `AbilityData` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação de `AbilityData`s.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `AbilityData`s para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `ability_panel.tscn` e `ability_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar os `AbilityData`s carregados.
    -   Ferramentas para criar e editar `AbilityData`s.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de habilidades.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversas `AbilityData`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Editor Visual de Habilidades:** Uma ferramenta visual para criar e gerenciar o fluxo de habilidades e seus efeitos.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `StateCafe` para estados de combate, `VFXCafe` para efeitos visuais).
