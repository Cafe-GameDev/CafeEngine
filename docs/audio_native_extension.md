### Projeto de Lei para a Experiência do Usuário e Extensão Nativa do AudioCafe

**Preâmbulo:**
Reconhecendo a importância primordial da experiência do usuário (UX) no desenvolvimento de jogos e a necessidade de ferramentas que se integrem de forma fluida e intuitiva ao ambiente do Godot Engine, o CafeEngine propõe a presente legislação para o módulo `AudioCafe`. Este Projeto de Lei visa estabelecer mandatos que garantam que o `AudioCafe` não apenas seja o padrão definitivo para áudio, mas que sua utilização seja a mais nativa, completa e poderosa possível, capacitando desenvolvedores com controle sem precedentes sobre seus ativos sonoros.

**Artigo I: Da Experiência do Usuário e Integração Nativa no Editor**

**Seção 1.1: Mandato de Painel de Controle Unificado e Intuitivo (AudioPanel):**
O `AudioCafe` deverá consolidar todas as suas configurações e funcionalidades de gerenciamento de áudio em um `AudioPanel` centralizado, integrado ao `CafePanel` principal do editor. Este painel será projetado com uma interface de usuário (UI) que siga rigorosamente as diretrizes de design do Godot, utilizando controles nativos e um layout intuitivo.

*   **Diretriz Operacional 1.1.1: Acessibilidade:** O `AudioPanel` deverá prover acesso rápido e claro a todas as configurações do `audio_config.tres`, incluindo volumes, caminhos de assets, e configurações de playlists.
*   **Diretriz Operacional 1.1.2: Feedback Visual:** O painel deverá oferecer feedback visual imediato sobre o estado do sistema de áudio, como o progresso da geração do `AudioManifest` e a validade dos caminhos de assets.

**Seção 1.2: Mandato de Inspetor Contextual e Inteligente (EditorInspectorPlugin):**
O `AudioCafe` deverá aprimorar a interação do usuário com as propriedades de áudio diretamente no painel Inspetor do Godot, utilizando o `EditorInspectorPlugin`.

*   **Diretriz Operacional 1.2.1: UI Personalizada:** Serão desenvolvidas interfaces de usuário personalizadas para propriedades de recursos (`AudioConfig`, `AudioManifest`) e nós (`AudioPosition`, `SFXButton`), exibindo apenas informações relevantes e oferecendo controles contextuais.
*   **Diretriz Operacional 1.2.2: Validação Visual:** O Inspetor deverá prover validação visual em tempo real para as propriedades de áudio, indicando erros ou inconsistências (ex: caminhos inválidos, chaves duplicadas) de forma clara.
*   **Diretriz Operacional 1.2.3: Ações Rápidas:** Botões e links diretos para ações comuns (ex: "Gerar Manifest", "Abrir Documentação") serão integrados ao Inspetor quando apropriado, agilizando o fluxo de trabalho.

**Seção 1.3: Mandato de Componentes Nativos e Extensíveis:**
Todos os componentes do `AudioCafe` (ex: `SFXButton`, `AudioPosition`) deverão ser registrados como tipos customizados (`add_custom_type`), garantindo que se comportem e se sintam como nós nativos do Godot, facilmente adicionáveis à árvore de cenas e editáveis no Inspetor.

**Artigo II: Do Importador de Áudio Avançado e Repartição de Assets**

**Seção 2.1: Mandato de Importador de Áudio Abrangente (EditorImportPlugin):**
O `AudioCafe` deverá implementar um `EditorImportPlugin` avançado, capaz de processar e importar diversos formatos de áudio (incluindo `.mp3`, `.ogg`, `.wav`, entre outros), superando as funcionalidades do importador nativo do Godot em termos de controle e flexibilidade.

*   **Diretriz Operacional 2.1.1: Suporte a Formatos:** O importador deverá garantir compatibilidade com os formatos de áudio mais comuns na indústria de jogos.
*   **Diretriz Operacional 2.1.2: Paridade e Melhoria:** Todas as funcionalidades existentes no importador nativo do Godot (ex: compressão, looping, barramento padrão) deverão ser replicadas e, quando possível, aprimoradas.

**Seção 2.2: Mandato de Repartição de Áudios por Segmentos:**
O importador de áudio avançado deverá introduzir a funcionalidade de **repartição automática de arquivos de áudio longos em múltiplos segmentos sequenciais** durante o processo de importação.

*   **Diretriz Operacional 2.2.1: Configuração de Segmentação:** O usuário poderá definir parâmetros de segmentação, como a duração de cada segmento (ex: 10 segundos), ou marcadores baseados em silêncio ou picos de áudio.
*   **Diretriz Operacional 2.2.2: Geração de Múltiplos Assets:** Um único arquivo de áudio de entrada (ex: uma música de 9 minutos) será transformado em múltiplos arquivos de áudio menores (ex: 54 segmentos de 10 segundos), cada um com seu próprio UID e referência no `AudioManifest`.
*   **Diretriz Operacional 2.2.3: Nomenclatura e Acessibilidade:** Os segmentos serão nomeados de forma padronizada (ex: `musica_faroeste_001.ogg`, `musica_faroeste_002.ogg`) e suas referências serão armazenadas no `AudioManifest` de forma a permitir a reprodução de um segmento específico.

**Seção 2.3: Mandato de Reprodução por Tempo/Segmento:**
A funcionalidade de repartição de áudios permitirá que o `CafeAudioManager` reproduza um áudio a partir de um ponto específico no tempo, ou continue a reprodução de onde parou, mesmo que o áudio original seja longo.

*   **Diretriz Operacional 2.3.1: Mapeamento Temporal:** O `AudioManifest` deverá armazenar metadados que mapeiem o tempo original do áudio aos seus segmentos importados, permitindo que uma solicitação de "tocar a partir de 2:32" seja traduzida para a reprodução do segmento correto.
*   **Diretriz Operacional 2.3.2: Continuidade:** O `CafeAudioManager` será capaz de gerenciar o estado de reprodução de áudios longos, permitindo que o jogo salve o último ponto de reprodução e retome a partir daquele segmento e tempo específicos.

**Artigo III: Da Arquitetura e Tecnologia para Extensão Nativa**

**Seção 3.1: Mandato de GDScript como Base:**
O `GDScript` será mantido como a linguagem primária para a lógica de editor e de jogo do `AudioCafe`, aproveitando sua integração nativa com o Godot e sua facilidade de uso para a maioria das funcionalidades.

**Seção 3.2: Mandato de GXExtension para Otimização e Funcionalidades Críticas:**
Para funcionalidades que exigem alto desempenho, acesso a APIs de baixo nível do sistema operacional, ou processamento complexo de áudio que não é otimizado em `GDScript`, o `AudioCafe` deverá utilizar `GXExtension` (Godot Extension) com linguagens como C++ ou outras, conforme necessário.

*   **Diretriz Operacional 3.2.1: Processamento de Áudio:** O importador de áudio avançado, especialmente a funcionalidade de repartição e qualquer manipulação de dados de áudio em nível de byte, será implementado via `GXExtension` para garantir velocidade e eficiência.
*   **Diretriz Operacional 3.2.2: Otimizações de Tempo de Execução:** Qualquer lógica de áudio que se mostre um gargalo de desempenho em `GDScript` durante o perfilamento será candidata à reimplementação via `GXExtension`.

**Conclusão:**
Este Projeto de Lei estabelece um roteiro ambicioso para o `AudioCafe`, transformando-o em uma ferramenta que não apenas atende, mas supera as expectativas dos desenvolvedores em termos de experiência do usuário e controle de áudio. Ao combinar uma integração nativa profunda com funcionalidades de importação e reprodução de ponta, impulsionadas por uma arquitetura híbrida `GDScript`/`GXExtension`, o `AudioCafe` se consolidará como a solução definitiva para o áudio no Godot Engine, capacitando a criação de mundos sonoros verdadeiramente imersivos e reativos.
