# ShopCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-08
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **ShopCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar sistemas de lojas (venda e compra de itens) de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem lojas, ofertas de itens, preços e estoques do seu jogo como Resources.

### 1.2. Filosofia

-   **Lojas e Ofertas como Resources:** Todas as definições de lojas (itens à venda, preços, moedas aceitas, estoques, descontos) são tratadas como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre a definição da loja/oferta e a lógica de jogo que processa as transações, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e desenvolvedores editem e ajustem os detalhes das lojas e ofertas diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de definições de itens comercializáveis e configurações de lojas entre diferentes NPCs, cidades ou eventos no seu jogo.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O ShopCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `ShopManager` (O Gerenciador de Lojas)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para gerenciar todas as lojas do jogo, processar transações de compra e venda, e interagir com o inventário do jogador e os sistemas de moeda. Ele pode carregar, armazenar e fornecer acesso a `ShopData`s e `ShopItemData`s.
-   **Funcionalidades Planejadas:**
    -   Processar a compra de itens, verificando moeda e espaço no inventário.
    -   Processar a venda de itens do inventário do jogador.
    -   Gerenciar estoques de lojas.
    -   Aplicar descontos e bônus.
    -   Emitir sinais para notificar outros sistemas sobre transações (ex: `item_bought`, `currency_changed`).

### 2.2. `ShopData` (A Base para Definições de Lojas)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todas as definições de lojas específicas do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
-   **Exemplos de Implementação:**
    -   `GeneralShop`: Loja padrão com uma lista de itens.
    -   `LimitedStockShop`: Loja com estoque limitado para cada item.
    -   `DynamicShop`: Loja cujas ofertas mudam com o tempo ou eventos.

### 2.3. `ShopItemData` (A Base para Itens Comercializáveis)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para definir como um item específico é vendido ou comprado em uma loja. Ele pode encapsular o `ItemData` real do `InventoryCafe` e adicionar propriedades específicas de loja (preço, estoque, etc.).
-   **Exemplos de Implementação:**
    -   `StandardShopItem`: Item com preço fixo e estoque.
    -   `DiscountedShopItem`: Item com um preço promocional.

---

## 3. Estrutura de Arquivos Proposta

```
addons/shopcafe/
├── plugin.cfg
├── components/
│   └── shop_manager.gd
├── resources/
│   ├── shop_config.tres
│   └── shops/ # Subpasta para todos os ShopData (recursos)
│       ├── shop_data.gd
│       ├── general_shop.gd
│       └── limited_stock_shop.gd
│   └── shop_items/ # Subpasta para todos os ShopItemData (recursos)
│       ├── shop_item_data.gd
│       └── standard_shop_item.gd
├── panel/
│   ├── shop_panel.gd
│   └── shop_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── shop_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `shop_data.gd` e `shop_item_data.gd` como classes base.
-   [ ] **Criar `ShopManager`:** Implementar `shop_manager.gd` como um autoload singleton.
-   [ ] **Criar Definições de Lojas e Itens de Exemplo:** Desenvolver `GeneralShop` e `StandardShopItem` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir lojas e itens comercializáveis através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `ShopData`, `ShopItemData` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `shop_panel.tscn` e `shop_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar `ShopData`s e `ShopItemData`s carregados.
    -   Ferramentas para criar e editar.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de sistemas de lojas.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversos `ShopData`s e `ShopItemData`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Editor Visual de Lojas:** Uma ferramenta visual para criar e gerenciar o layout de lojas e a disposição dos itens.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `InventoryCafe` para itens, `DataCafe` para moedas e dados de itens).
-   **Sistema de Reputação/Descontos:** Lojas que oferecem preços diferentes com base na reputação do jogador ou em eventos.
