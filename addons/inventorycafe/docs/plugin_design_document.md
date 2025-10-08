# InventoryCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-07
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **InventoryCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar inventários e itens de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem itens complexos do seu jogo como Resources.

### 1.2. Filosofia

-   **Itens como Resources:** Todas as definições de itens (propriedades, efeitos, empilhamento, ícones) são tratadas como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre a definição do item e a lógica de jogo que o utiliza, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e desenvolvedores editem e ajustem os detalhes dos itens diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de definições de itens entre diferentes inventários, lojas, sistemas de crafting ou drops de inimigos.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O InventoryCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `InventoryManager` (O Gerenciador de Inventários)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para gerenciar múltiplos inventários no jogo (ex: inventário do jogador, inventários de NPCs, baús). Ele pode carregar, armazenar e fornecer acesso a `ItemData`s e gerenciar a lógica de adição/remoção de itens.
-   **Funcionalidades Planejadas:**
    -   Adicionar, remover e mover itens entre inventários.
    -   Gerenciar o empilhamento de itens.
    -   Emitir sinais para notificar o UI ou outros sistemas sobre mudanças no inventário.

### 2.2. `ItemData` (A Base para Definições de Itens)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todas as definições de itens específicos do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
-   **Exemplos de Implementação:**
    -   `ConsumableItem`: Poções, comida.
    -   `EquipmentItem`: Armas, armaduras.
    -   `QuestItem`: Itens específicos de quests.

---

## 3. Estrutura de Arquivos Proposta

```
addons/inventorycafe/
├── plugin.cfg
├── components/
│   └── inventory_manager.gd
├── resources/
│   ├── inventory_config.tres
│   └── item_data/ # Subpasta para todos os ItemData (recursos)
│       ├── item_data.gd
│       ├── consumable_item.gd
│       └── equipment_item.gd
├── panel/
│   ├── inventory_panel.gd
│   └── inventory_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── inventory_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `item_data.gd` como a classe base para todos os recursos de item.
-   [ ] **Criar `InventoryManager`:** Implementar `inventory_manager.gd` como um autoload singleton.
-   [ ] **Criar Definições de Itens de Exemplo:** Desenvolver `ConsumableItem` e `EquipmentItem` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir e gerenciar itens através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `ItemData` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação de `ItemData`s.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `ItemData`s para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `inventory_panel.tscn` e `inventory_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar os `ItemData`s carregados.
    -   Ferramentas para criar e editar `ItemData`s.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de inventários.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversos `ItemData`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Editor Visual de Inventário:** Uma ferramenta visual para criar e gerenciar layouts de inventário e slots.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `CraftingCafe` para receitas, `ShopCafe` para vendas).
