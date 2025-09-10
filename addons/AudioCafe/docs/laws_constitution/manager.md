# Constituição do Gerenciador Central

**Status:** Constitucional
**Documento:** `docs/laws_constitution/manager.md`

---

### **Artigo I: Propósito e Função**

O `CafeAudioManager` é o **singleton orquestrador** do sistema. Ele existe como um nó global (`Autoload`) e serve como o ponto central de execução para todas as operações de áudio em tempo de execução.

### **Artigo II: Responsabilidades Fundamentais**

As responsabilidades invioláveis do `CafeAudioManager` na v1.0 são:

1.  **Pooling de SFX:** Gerenciar um pool de nós `AudioStreamPlayer` para a reprodução eficiente de efeitos sonoros, evitando o custo de instanciar nós repetidamente.
2.  **Reprodução de Música:** Gerenciar um `AudioStreamPlayer` dedicado para a reprodução de música, incluindo a lógica para seleção aleatória de faixas dentro de uma playlist definida no `AudioManifest`.
3.  **Dispatcher de Sinais:** Atuar como o hub central para receber sinais de requisição (ex: `play_sfx_requested`) e emitir sinais de notificação (ex: `volume_changed`).
4.  **Gerenciamento de Buses:** Garantir a existência e o controle de volume dos buses de áudio "Music" e "SFX".
