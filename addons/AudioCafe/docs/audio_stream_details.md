# Detalhes dos Recursos AudioStream no Godot Engine

Este documento detalha o funcionamento do `AudioStream` base e dos novos recursos de áudio introduzidos no Godot Engine 4.3, que permitem a criação de sistemas de áudio mais dinâmicos e complexos.

## 1. AudioStream (Classe Base)

`AudioStream` é a classe base para todos os tipos de fluxos de áudio no Godot Engine. Ele representa um recurso de áudio que pode ser reproduzido por nós como `AudioStreamPlayer`, `AudioStreamPlayer2D` e `AudioStreamPlayer3D`.

**Como funciona:**
Um `AudioStream` encapsula os dados de áudio (como um arquivo .ogg ou .wav) e suas propriedades básicas, como taxa de amostragem, formato e duração. Ele não reproduz o áudio por si só, mas serve como a "fonte" de áudio para os nós `AudioStreamPlayer`. Quando você atribui um `AudioStream` a um `AudioStreamPlayer` e chama `play()`, o nó de player é responsável por processar e emitir o som.

**Uso:**
Você normalmente carrega um arquivo de áudio (que se torna um `AudioStreamOggVorbis` ou `AudioStreamWAV` internamente) e o atribui à propriedade `stream` de um `AudioStreamPlayer`.

```gdscript
# Exemplo básico de uso de AudioStream
var my_sound = load("res://assets/sfx/my_sfx.ogg")
$AudioStreamPlayer.stream = my_sound
$AudioStreamPlayer.play()
```

## 2. AudioStreamPlaylist

`AudioStreamPlaylist` é um recurso de áudio que contém uma lista de outros `AudioStream`s e os reproduz em sequência ou aleatoriamente.

**Como funciona:**
Em vez de um único arquivo de áudio, o `AudioStreamPlaylist` gerencia uma coleção de `AudioStream`s. Você adiciona os streams à sua lista interna. Ele pode ser configurado para:
*   **Reprodução Sequencial**: Toca os streams na ordem em que foram adicionados.
*   **Reprodução Aleatória (Shuffle)**: Escolhe um stream aleatoriamente da lista.
*   **Pesos**: Você pode atribuir pesos a cada stream para influenciar a probabilidade de ser escolhido no modo aleatório.
*   **Transições**: Permite definir um tempo de fade para transições suaves entre as faixas.

**Uso:**
Ideal para músicas de fundo em áreas de jogo onde você deseja variedade sem repetição óbvia. Por exemplo, uma playlist para a música de exploração de um nível.

```gdscript
# Exemplo de uso de AudioStreamPlaylist
var playlist = AudioStreamPlaylist.new()
playlist.add_stream(load("res://assets/music/track1.ogg"))
playlist.add_stream(load("res://assets/music/track2.ogg"))
playlist.add_stream(load("res://assets/music/track3.ogg"))

# Configura para reprodução aleatória
playlist.set_mode(AudioStreamPlaylist.PLAYBACK_MODE_SHUFFLE)

$AudioStreamPlayer.stream = playlist
$AudioStreamPlayer.play()
```

## 3. AudioStreamSynchronized

`AudioStreamSynchronized` é um recurso usado para sincronizar a reprodução de múltiplos fluxos de áudio.

**Como funciona:**
Ele permite que você tenha vários `AudioStream`s que começam e param exatamente ao mesmo tempo. Você define um `base_stream` e outros streams são sincronizados com ele. Isso é crucial para música em camadas (stems), onde diferentes elementos musicais (como bateria, baixo, melodia) precisam estar em perfeita sincronia, mesmo que sejam controlados independentemente.

**Uso:**
Perfeito para música adaptativa onde a intensidade ou os elementos musicais mudam dinamicamente. Por exemplo, em uma cena de combate, você pode ter um `AudioStreamSynchronized` que reproduz a melodia e a bateria, e então adicionar ou remover um "stem" de baixo ou guitarra para aumentar a intensidade da música, tudo em perfeita sincronia.

```gdscript
# Exemplo conceitual de uso de AudioStreamSynchronized
var synchronized_music = AudioStreamSynchronized.new()
synchronized_music.base_stream = load("res://assets/music/melody_loop.ogg")

# Outros streams seriam adicionados e controlados para sincronizar com o base_stream
# Isso geralmente é feito através de um AudioStreamPlaybackSynchronized em um AudioStreamPlayer
```

## 4. AudioStreamInteractive

`AudioStreamInteractive` é o recurso mais poderoso para música adaptativa e interativa, funcionando como uma máquina de estado de áudio visual.

**Como funciona:**
Ele permite criar transições dinâmicas e suaves entre diferentes segmentos musicais ou estados de áudio. Você pode definir múltiplos "clipes" de áudio e criar "estados" que representam diferentes seções ou intensidades da música (ex: "exploração", "combate", "tensão"). As transições entre esses estados podem ser configuradas com regras (automáticas, por gatilho) e tempos de crossfade, tudo através de um editor de grafo visual no Godot.

**Uso:**
Ideal para trilhas sonoras que reagem diretamente à jogabilidade. Por exemplo, a música pode mudar de um tema calmo de exploração para um tema mais intenso quando o jogador entra em combate, ou para um tema de tensão quando um inimigo se aproxima. Você pode aninhar instâncias de `AudioStreamInteractive` para criar sistemas de áudio adaptativos muito complexos.

```gdscript
# Exemplo conceitual de uso de AudioStreamInteractive
# (A configuração principal é feita no editor de grafo visual)

# No código, você controlaria as transições:
# var interactive_music = load("res://resources/my_interactive_music.tres")
# $AudioStreamPlayer.stream = interactive_music
# $AudioStreamPlayer.play()

# Para mudar de estado (ex: de exploração para combate):
# var playback = $AudioStreamPlayer.get_stream_playback() as AudioStreamPlaybackInteractive
# if playback:
#     playback.travel("combat_state")
```

## 5. Classes AudioStreamPlayback

Enquanto os recursos `AudioStream` definem os dados e a lógica de reprodução, as classes `AudioStreamPlayback` são as instâncias de tempo de execução que realmente gerenciam a reprodução do áudio. Você as obtém de um `AudioStreamPlayer` usando o método `get_stream_playback()`.

### AudioStreamPlayback (Classe Base)

`AudioStreamPlayback` é a classe base para todas as instâncias de playback de `AudioStream`. Ela fornece a interface comum para controlar a reprodução de um fluxo de áudio.

**Como funciona:**
Quando um `AudioStreamPlayer` começa a reproduzir um `AudioStream`, ele cria uma instância de `AudioStreamPlayback` correspondente. Esta instância é responsável por gerenciar o estado da reprodução (pausado, tocando, posição atual), mas não é criada ou manipulada diretamente pelo usuário na maioria dos casos. Você a acessa para interagir com o fluxo de áudio em tempo real.

**Uso:**
Você geralmente obtém uma referência a ela para acessar métodos específicos do tipo de `AudioStream` que está sendo reproduzido.

```gdscript
# Exemplo de como obter um AudioStreamPlayback
var playback = $AudioStreamPlayer.get_stream_playback()
if playback:
    print("Posição atual do playback: ", playback.get_playback_position())
```

### AudioStreamPlaybackPlaylist

`AudioStreamPlaybackPlaylist` é a instância de playback para um recurso `AudioStreamPlaylist`. Ele permite controlar a navegação e o estado da playlist em tempo de execução.

**Como funciona:**
Ele gerencia qual faixa da playlist está sendo reproduzida, permite avançar ou retroceder na playlist e fornece informações sobre o estado atual da reprodução da playlist.

**Uso:**
Para controlar uma playlist dinamicamente no código.

```gdscript
# Exemplo de uso de AudioStreamPlaybackPlaylist
var playback = $AudioStreamPlayer.get_stream_playback() as AudioStreamPlaybackPlaylist
if playback:
    playback.play_next() # Toca a próxima faixa na playlist
    print("Faixa atual da playlist: ", playback.get_current_index())
```

### AudioStreamPlaybackSynchronized

`AudioStreamPlaybackSynchronized` é a instância de playback para um recurso `AudioStreamSynchronized`. Ele gerencia a reprodução sincronizada de múltiplos streams.

**Como funciona:**
Ele garante que todos os streams associados ao `AudioStreamSynchronized` permaneçam em perfeita sincronia, mesmo que suas durações ou pontos de início sejam diferentes. Ele coordena a reprodução de todos os sub-streams.

**Uso:**
Para controlar a reprodução de música em camadas ou outros áudios que exigem sincronização precisa.

```gdscript
# Exemplo de uso de AudioStreamPlaybackSynchronized
var playback = $AudioStreamPlayer.get_stream_playback() as AudioStreamPlaybackSynchronized
if playback:
    # Você pode interagir com os sub-playbacks se necessário
    # Por exemplo, para pausar um stem específico
    # playback.get_sub_playback(0).stop()
    pass # A sincronização é gerenciada automaticamente
```

### AudioStreamPlaybackInteractive

`AudioStreamPlaybackInteractive` é a instância de playback para um recurso `AudioStreamInteractive`. Ele permite controlar as transições entre os estados de áudio interativos.

**Como funciona:**
Ele é a interface de tempo de execução para a máquina de estado de áudio definida no `AudioStreamInteractive`. Você usa seus métodos para disparar transições entre os estados definidos no editor visual.

**Uso:**
Para mudar dinamicamente a música ou o áudio ambiente com base em eventos do jogo.

```gdscript
# Exemplo de uso de AudioStreamPlaybackInteractive
var playback = $AudioStreamPlayer.get_stream_playback() as AudioStreamPlaybackInteractive
if playback:
    playback.travel("combat_state") # Transita para o estado de combate
    print("Estado atual do áudio interativo: ", playback.get_current_state())
```