# Uso do Plugin CafeAudioManager

O `CafeAudioManager` opera principalmente através de sinais, funcionando como um EventBus. Isso significa que você emite sinais para solicitar a reprodução de áudio ou alterações de volume, e o gerenciador cuida das operações de áudio reais.

## 1. Sinais (EventBus de Áudio)

O `CafeAudioManager` emite e escuta sinais específicos para gerenciar eventos de áudio.

### 1.1. Sinais Emitidos

Estes sinais são emitidos pelo `CafeAudioManager` para notificar outras partes do seu jogo sobre eventos de áudio. Você pode se conectar a esses sinais a partir de qualquer script que precise reagir a mudanças de áudio.

*   `music_track_changed(music_key: String)`
    *   **Descrição:** Emitido quando uma nova faixa de música começa a tocar.
    *   **Parâmetros:**
        *   `music_key`: A chave de string da faixa de música que acabou de começar.
    *   **Caso de Uso Exemplo:** Atualizar um elemento da UI para mostrar o título da música atual.

*   `volume_changed(bus_name: String, linear_volume: float)`
    *   **Descrição:** Emitido sempre que o volume de um bus de áudio é alterado.
    *   **Parâmetros:**
        *   `bus_name`: O nome do bus de áudio cujo volume foi alterado (ex: "Master", "Music", "SFX").
        *   `linear_volume`: O novo valor de volume linear (0.0 a 1.0).
    *   **Caso de Uso Exemplo:** Atualizar um slider de volume no seu menu de opções.

### 1.2. Sinais Escutados

Estes sinais são escutados pelo `CafeAudioManager`. Você deve emitir esses sinais a partir da sua lógica de jogo para solicitar a reprodução de áudio ou ajustes de volume.

*   `play_sfx_requested(sfx_key: String, bus: String = "SFX", manager_node: Node = null)`
    *   **Descrição:** Solicita ao `CafeAudioManager` que reproduza um efeito sonoro específico.
    *   **Parâmetros:**
        *   `sfx_key`: (String) A chave do SFX a ser reproduzido, conforme definido no seu `AudioManifest`.
        *   `bus`: (String, opcional) O nome do bus de áudio para reproduzir o SFX (ex: "SFX", "UI"). Padrão: "SFX".
        *   `manager_node`: (Node, opcional, para v2.0) Um nó `CafeAudioPlayer2D/3D` que deve gerenciar a reprodução posicional do áudio. Se `null`, o `CafeAudioManager` lida com a reprodução não posicional.
    *   **Exemplo:** `CafeAudioManager.play_sfx_requested.emit("sfx_pulo", "SFX")`

*   `play_music_requested(music_key: String, manager_node: Node = null)`
    *   **Descrição:** Solicita ao `CafeAudioManager` que reproduza uma faixa de música específica ou inicie uma playlist.
    *   **Parâmetros:**
        *   `music_key`: (String) A chave da faixa de música ou playlist a ser reproduzida, conforme definido no seu `AudioManifest`.
        *   `manager_node`: (Node, opcional, para v2.0) Um nó `CafeAudioPlayer2D/3D` que deve gerenciar a reprodução posicional do áudio. Se `null`, o `CafeAudioManager` lida com a reprodução não posicional.
    *   **Exemplo:** `CafeAudioManager.play_music_requested.emit("tema_nivel_1")`

*   `volume_changed(bus_name: String, linear_volume: float)`
    *   **Descrição:** O `CafeAudioManager` escuta seu próprio sinal `volume_changed` para aplicar ajustes de volume ao bus de áudio especificado. Isso permite uma maneira consistente de alterar o volume de qualquer parte da sua aplicação.
    *   **Parâmetros:** Os mesmos do sinal `volume_changed` emitido.
    *   **Exemplo:** `CafeAudioManager.volume_changed.emit("Musica", 0.75)`

## 2. Reproduzindo Efeitos Sonoros (SFX)

Para reproduzir um SFX, basta emitir o sinal `play_sfx_requested` com a `sfx_key` apropriada e, opcionalmente, o nome do `bus`.

```gdscript
# Exemplo: Reproduzir um efeito sonoro de pulo no bus "SFX"
CafeAudioManager.play_sfx_requested.emit("sfx_pulo", "SFX")

# Exemplo: Reproduzir um efeito sonoro de clique de UI no bus "UI" (se você tiver um configurado)
CafeAudioManager.play_sfx_requested.emit("clique_botao", "UI")
```

## 3. Reproduzindo Música

Para reproduzir uma faixa de música ou iniciar uma playlist, emita o sinal `play_music_requested` com a `music_key` correspondente.

```gdscript
# Exemplo: Reproduzir uma faixa de música de fundo específica
CafeAudioManager.play_music_requested.emit("tema_nivel_1")

# Exemplo: Iniciar uma playlist de música (se configurada no seu AudioManifest)
CafeAudioManager.play_music_requested.emit("playlist_menu_principal")
```

## 4. Controle de Volume

Para alterar o volume de um bus de áudio, emita o sinal `volume_changed`.

```gdscript
# Exemplo: Definir o volume Master para 50%
CafeAudioManager.volume_changed.emit("Master", 0.5)

# Exemplo: Definir o volume da Música para 75%
CafeAudioManager.volume_changed.emit("Musica", 0.75)

# Exemplo: Silenciar SFX (definir volume para 0%)
CafeAudioManager.volume_changed.emit("SFX", 0.0)
```