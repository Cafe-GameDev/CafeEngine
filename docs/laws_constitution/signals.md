# Constituição da API de Sinais

**Status:** Constitucional
**Documento:** `docs/laws_constitution/signals.md`

---

### **Artigo I: Princípio da Comunicação Desacoplada**

A comunicação entre os diferentes plugins e entre um plugin e o código do usuário **DEVE** ser feita, preferencialmente, através de um conjunto bem definido de sinais globais, emitidos a partir do Autoload de cada plugin. Isso garante baixo acoplamento e alta modularidade.

### **Artigo II: Princípio da Clareza da API**

Os sinais devem ter nomes claros e descritivos que indiquem sua função e o plugin de origem (ex: `AudioCafe.music_track_changed`, `SaveCafe.save_completed`). Seus parâmetros devem ser bem definidos e tipados.

### **Artigo III: Princípio da Estabilidade da API**

Uma vez que um sinal é definido como parte da API pública de um plugin, sua assinatura (nome e parâmetros) deve ser considerada estável. Qualquer alteração que quebre a compatibilidade de um sinal público **DEVE** ser tratada como uma quebra de compatibilidade maior e resultar em um incremento da versão `MAJOR` do plugin, conforme a "Constituição do Versionamento".
