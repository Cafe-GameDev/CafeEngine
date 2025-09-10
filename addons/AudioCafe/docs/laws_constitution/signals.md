# Constituição da API de Sinais

**Status:** Constitucional
**Documento:** `docs/laws_constitution/signals.md`

---

### **Artigo I: Propósito e Função**

Os sinais são a **API pública e o sistema nervoso** do AudioCafe. Eles permitem uma comunicação desacoplada entre os componentes do plugin e o código do jogo. Esta constituição define os sinais essenciais da v1.0.

### **Artigo II: Sinais Invioláveis**

Os seguintes sinais formam o núcleo da API de eventos do AudioCafe:

1.  **Sinais de Requisição (Emitidos pelo Jogo):**
    *   `play_sfx_requested(sfx_key: String, bus: String, manager_node: Node)`: A única forma de solicitar a reprodução de um SFX.
    *   `play_music_requested(music_key: String, manager_node: Node)`: A única forma de solicitar a reprodução de uma música ou playlist.

2.  **Sinais de Notificação (Escutados pelo Jogo):**
    *   `music_track_changed(music_key: String)`: Notifica quando uma nova faixa de música começa.
    *   `volume_changed(bus_name: String, linear_volume: float)`: Notifica quando um volume de bus é alterado.
    *   `zone_event_triggered(zone_name: String, event_type: String, body: Node)`: Notifica sobre eventos de `AudioZone`.
    *   `audio_config_updated(config: AudioConfig)`: Notifica sobre mudanças no `AudioConfig`.
