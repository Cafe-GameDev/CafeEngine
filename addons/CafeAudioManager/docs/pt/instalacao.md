# Instalação do Plugin CafeAudioManager

Para integrar o `CafeAudioManager` em seu projeto Godot, siga estes passos detalhados:

## 1. Adicionar a Pasta do Plugin

Copie a pasta completa `CafeAudioManager` para o diretório `addons/` do seu projeto Godot. Se a pasta `addons/` não existir, crie-a no diretório raiz do seu projeto.

*   **Estrutura Esperada:** A estrutura do seu projeto deve ser semelhante a: `seu_projeto_raiz/addons/CafeAudioManager/...`

## 2. Ativar o Plugin

1.  Abra seu projeto Godot no editor.
2.  Vá em `Projeto` -> `Configurações do Projeto...`.
3.  Navegue até a aba `Plugins`.
4.  Localize `CafeAudioManager` na lista e certifique-se de que seu status esteja definido como `Ativo`.

## 3. Configurar como Autoload (Singleton)

1.  Nas `Configurações do Projeto...`, vá para a aba `Autoload`.
2.  Clique no botão `Adicionar` (ícone de pasta) para procurar um caminho.
3.  Navegue até `res://addons/CafeAudioManager/scenes/cafe_audio_manager.tscn` e selecione-o.
4.  No campo `Nome do Nó`, digite `CafeAudioManager` (ou o nome de singleton de sua preferência).
5.  Certifique-se de que `Habilitar` esteja marcado.
6.  Clique em `Adicionar`. Isso torna o `CafeAudioManager` acessível globalmente a partir de qualquer script.

**Ponto para Imagem:** Uma imagem aqui mostrando a janela de `Configurações do Projeto > Autoload` com o `CafeAudioManager` adicionado e habilitado seria muito útil.

## 4. Gerar AudioManifest

Este é um passo crucial tanto para o desenvolvimento quanto para builds exportadas.

*   Siga as instruções detalhadas na seção [Geração do AudioManifest](../configuracao.md#geracao-do-audiomanifest) na documentação de Configuração.

## 5. Refatorar Chamadas de Áudio (Migração)

Se você estiver migrando de um sistema de áudio existente, será necessário atualizar seu código:

*   Substitua quaisquer chamadas diretas a um `AudioManager` antigo ou sinais de áudio de um singleton `GlobalEvents` pelas emissões de sinal apropriadas do `CafeAudioManager`.
*   **Exemplo:** Em vez de `GlobalEvents.emit_signal("play_sfx", "jump")`, você usaria `CafeAudioManager.play_sfx_requested.emit("jump", "SFX")`.