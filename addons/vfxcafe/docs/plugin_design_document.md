# VFXCafe - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-08
**Autor:** Gemini (em colaboração com Cafe GameDev)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **VFXCafe** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar efeitos visuais (VFX) de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem efeitos visuais complexos do seu jogo como Resources.

### 1.2. Filosofia

-   **VFX como Resources:** Todas as definições de efeitos visuais (partículas, shaders, animações de sprite, sons associados, duração, gatilhos) são tratadas como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre a definição do VFX e a lógica de jogo que o invoca, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e desenvolvedores editem e ajustem os detalhes dos VFX diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de definições de VFX entre diferentes entidades, habilidades, eventos ou situações do jogo.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O VFXCafe tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `VFXManager` (O Gerenciador de Efeitos Visuais)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para instanciar, gerenciar e controlar a reprodução de efeitos visuais no jogo. Ele pode carregar, armazenar e fornecer acesso a `VFXData`s.
-   **Funcionalidades Planejadas:**
    -   Instanciar e reproduzir VFX em posições específicas ou anexados a nós.
    -   Gerenciar pools de VFX para otimização de performance.
    -   Parar e pausar VFX.
    -   Emitir sinais para notificar outros sistemas sobre o ciclo de vida de um VFX (ex: `vfx_finished`).

### 2.2. `VFXData` (A Base para Definições de Efeitos Visuais)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todas as definições de efeitos visuais específicos do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
-   **Exemplos de Implementação:**
    -   `ParticleVFX`: Efeitos baseados em sistemas de partículas (GPUParticles2D/3D).
    -   `AnimationVFX`: Efeitos baseados em animações (AnimationPlayer, AnimatedSprite2D/3D).
    -   `ShaderVFX`: Efeitos que modificam visualmente um nó através de shaders.
    -   `CombinedVFX`: Combinação de múltiplos tipos de VFX.

---

## 3. Estrutura de Arquivos Proposta

```
addons/vfxcafe/
├── plugin.cfg
├── components/
│   └── vfx_manager.gd
├── resources/
│   ├── vfx_config.tres
│   └── vfx_data/ # Subpasta para todos os VFXData (recursos)
│       ├── vfx_data.gd
│       ├── particle_vfx.gd
│       └── animation_vfx.gd
├── panel/
│   ├── vfx_panel.gd
│   └── vfx_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── vfx_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `vfx_data.gd` como a classe base para todos os recursos de VFX.
-   [ ] **Criar `VFXManager`:** Implementar `vfx_manager.gd` como um autoload singleton.
-   [ ] **Criar Definições de VFX de Exemplo:** Desenvolver `ParticleVFX` e `AnimationVFX` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir e reproduzir efeitos visuais através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `VFXData` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação de `VFXData`s.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `VFXData`s para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `vfx_panel.tscn` e `vfx_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar os `VFXData`s carregados.
    -   Ferramentas para criar e editar `VFXData`s.
    -   Funcionalidade de preview de VFX no editor.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de VFX.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversos `VFXData`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Editor Visual de VFX:** Uma ferramenta visual para criar e gerenciar o fluxo de múltiplos componentes de VFX.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `CombatCafe` para efeitos de acerto, `StateCafe` para VFX de estados).
-   **Sistema de Pooling:** Gerenciamento automático de pools de nós de VFX para otimização de performance.
