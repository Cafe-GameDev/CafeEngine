# Constituição da API de Sinais (StateCafe)

**Status:** Constitucional
**Documento:** `addons/StateCafe/docs/laws_constitution/signals.md`

---

### **Artigo I: Comunicação de Mudança de Estado**

O `StateGlobal` **DEVE** emitir sinais claros e globais quando um estado de jogo significativo for alterado (ex: `state_changed(object, new_state)`), permitindo que outros sistemas (como `AudioCafe` ou `TransitionCafe`) reajam de forma desacoplada.

### **Artigo II: Estabilidade**

A assinatura dos sinais públicos do StateCafe é governada pela "Constituição da API de Sinais" do CafeEngine.
