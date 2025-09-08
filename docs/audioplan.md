### **Documento de Design Final: Sistema de Áudio Posicional**

#### **1. `CafeAudioManager` (Modificações)**
*   **Função:** O `CafeAudioManager` irá **expandir e refinar seu papel** como o EventBus de áudio central do projeto. Ele continuará sendo o ponto de entrada para solicitações de áudio globais, mas sua lógica interna será modificada: ele evoluirá de um "toca-tudo" para um **"bibliotecário" de recursos** e um roteador de eventos mais sofisticado. Suas responsabilidades principais serão: 1) Gerenciar a máquina de estados da música, incluindo a lógica de `PlaybackMode` (Tocar e Parar, Loop Sequencial, Loop Aleatório, Tocar e Voltar) e a pilha de playlists para o comportamento de retorno. 2) Manter e gerenciar o *pool* de `AudioStreamPlayer`s para a reprodução de sons **não-posicionais**, como os de interface de usuário (UI), recebendo ordens através do seu sinal `play_sfx_requested`. 3) Controlar os barramentos de áudio globais, aplicando volumes e efeitos (como Reverb) conforme as configurações lidas do `audio_config`. 4) Servir como o "carteiro" para eventos de áudio globais, especificamente ao receber um evento de uma `AudioZone` e retransmiti-lo para todo o sistema através de um novo sinal `zone_event_triggered`, permitindo que componentes distantes reajam. Crucialmente, ele **deixa de ser o responsável** por carregar ou fornecer dados do `audio_manifest` e `audio_config` para outros nós; ele apenas os utiliza para suas próprias tarefas.

#### **2. `AudioConfig` (Recurso Global)**
*   **Função:** O `audio_config` atuará como uma **fonte de dados de configuração global, passiva e autônoma**. Ele terá um `class_name` (`AudioConfig`) para ser diretamente referenciável e pré-carregado por qualquer nó no projeto que necessite de suas informações. Sua única responsabilidade é armazenar dados de configuração, como os volumes padrão dos barramentos (Master, SFX, Music) e as chaves de SFX padrão para os componentes de UI (`default_click_key`, `default_hover_key`, etc.). Ele não contém lógica de reprodução, apenas os dados que outros sistemas irão ler para se configurarem. O `AudioPanel` será o único responsável por modificar este recurso, e o `CafeAudioManager` será um dos seus principais consumidores para ajustar os barramentos de áudio.

#### **3. `AudioManifest` (Recurso Global)**
*   **Função:** Similar ao `AudioConfig`, o `audio_manifest` será uma **fonte de dados global, passiva e autônoma** com um `class_name` (`AudioManifest`). Sua única função é servir como um dicionário que mapeia chaves de áudio legíveis por humanos (ex: "sfx_passos_grama") para um array de UIDs de recursos de áudio. Ele é a "lista telefônica" que permite a todo o sistema encontrar os arquivos de som reais a partir de uma chave abstrata. Componentes como o `AudioPosition` irão carregá-lo diretamente para consultar os UIDs necessários para a reprodução de sons posicionais, sem precisar passar pelo `CafeAudioManager`.

#### **4. `AudioPosition` (Novo Componente)**
*   **Função:** O `AudioPosition` é um nó que herda de `AudioStreamPlayer2D` ou `AudioStreamPlayer3D` e possui um `class_name`. Ele funciona como um **"microgerente" de áudio** para seu nó pai, com uma dupla responsabilidade. **Primeira:** tocar um som principal e contínuo (geralmente em loop) em si mesmo, que representa o estado primário de seu pai (ex: som de motor, passos correndo). Essa reprodução é controlada diretamente pelo pai através de uma chamada de método (`set_state("ESTADO")`), que usa um dicionário exportado (`state_sfx_map`) para encontrar a chave de áudio correta, buscar os UIDs no `audio_manifest` e tocar o som. **Segunda:** "terceirizar" a reprodução de sons secundários e simultâneos (ex: ataque, pulo). Para isso, ele expõe um método (`play_secondary_sound`) que, ao ser chamado (via sinal direto do pai), instancia um `AudioStreamPlayer` temporário como filho, busca o stream de áudio e o toca, gerenciando o ciclo de vida desse player temporário para que ele seja removido da cena após a conclusão do áudio (se não for um loop).

#### **5. `AudioZone` (Novo Componente)**
*   **Função:** A `AudioZone` é um componente de área que herda de `Area2D` ou `Area3D` e possui um `class_name`. Sua função é **detectar a entrada e saída de corpos específicos e disparar eventos de áudio ambientais**. Ela permitirá a configuração, via inspetor, de qual grupo ou `class_name` deve ser detectado. Ao ocorrer uma detecção (`body_entered` ou `body_exited`), a `AudioZone` não executa a lógica de áudio diretamente. Em vez disso, ela emite um sinal para o `CafeAudioManager` com uma carga de dados (payload) configurável, descrevendo o evento (ex: qual zona foi ativada, qual o alvo, qual ação tomar). O `CafeAudioManager` então retransmite essa informação para todo o sistema através do seu sinal `zone_event_triggered`, permitindo que qualquer outro nó (como um `AudioPosition` ou o próprio `CafeAudioManager`) reaja a essa mudança de ambiente acústico.

#### **6. `Nó Pai / _super` (Exemplo de Integração)**
*   **Função:** O nó Pai (ex: um `CharacterBody2D` representando o jogador) atua como o **orquestrador de seus `AudioPosition`s filhos**. Ele contém a(s) máquina(s) de estado e é responsável por traduzir os estados e ações do jogo em comandos de áudio. A arquitetura de controle é dividida em duas vias distintas: **1) Controle Direto:** Para o som de estado primário e contínuo, o script do Pai obtém uma referência direta ao seu `AudioPosition` principal (ex: `@onready var audio_movimento = $AudioPosition_Movement`) e comanda a mudança de som através de uma chamada de método direta (`audio_movimento.set_state("RUNNING")`) sempre que sua máquina de estados de movimento mudar. **2) Controle por Sinal Direto:** Para ações secundárias e pontuais, o script do Pai define e emite um sinal local (ex: `signal atacar_som(sfx_key)`). Este sinal é então conectado, através do inspetor do editor Godot, a um método no `AudioPosition` (ex: `play_secondary_sound`). Isso permite que a máquina de estados de ação do Pai (`fsm_acoes.emit_signal("atacar_som", "sfx_espada")`) dispare sons de ataque sem interromper o som de passos que já está tocando.

**Exemplo de Código GDScript para o Nó Pai:**

```gdscript
# Exemplo de script para um CharacterBody2D (Nó Pai)
extends CharacterBody2D

@onready var audio_movement: AudioPosition2D = $AudioPosition_Movement # Assumindo que AudioPosition_Movement é um nó filho
@onready var audio_actions: AudioPosition2D = $AudioPosition_Actions # Outro nó AudioPosition para ações

# Sinal para ações secundárias que podem ser conectadas via editor
signal attack_sound_requested(sfx_key: String)

func _ready():
    # Exemplo de conexão de sinal local para o AudioPosition_Actions
    attack_sound_requested.connect(audio_actions.play_secondary_sound)

func _physics_process(delta):
    # Lógica de movimento do personagem
    var current_state = get_current_movement_state() # Função hipotética que retorna o estado de movimento
    audio_movement.set_state(current_state) # Controle direto do som de movimento

    # Exemplo de disparo de som de ataque via sinal
    if Input.is_action_just_pressed("attack"):
        attack_sound_requested.emit("sfx_sword_swing") # Emite o sinal para tocar o som de ataque

func get_current_movement_state() -> String:
    # Lógica para determinar o estado de movimento (ex: "idle", "walking", "running")
    if velocity.length() > 0:
        return "running"
    return "idle"

```

**Exemplo de Código GDScript para uma AudioZone:**

```gdscript
# Exemplo de script para uma AudioZone2D
extends AudioZone2D

func _ready():
    # Conectar o sinal zone_event_triggered ao CafeAudioManager
    # CafeAudioManager deve ser um Autoload ou acessível globalmente
    if CafeAudioManager:
        zone_event_triggered.connect(CafeAudioManager._on_audio_zone_event_triggered)
    else:
        printerr("CafeAudioManager not found. AudioZone events will not be retransmitted.")

# Configurações de zone_name, target_group, target_class_name via Inspetor
# Ex: zone_name = "forest_area", target_group = "players"
```