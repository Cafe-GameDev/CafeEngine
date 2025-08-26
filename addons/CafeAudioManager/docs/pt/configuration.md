# Configuração do Plugin CafeAudioManager

O `CafeAudioManager` depende de algumas configurações chave para funcionar corretamente.

## 1. Geração do AudioManifest

O `AudioManifest` é um recurso `.tres` que atua como uma tabela de consulta para seus arquivos de áudio. Ele mapeia chaves de áudio amigáveis (ex: "sfx_pulo", "musica_fundo_1") para os IDs de recurso únicos (UIDs) que o Godot atribui aos arquivos de áudio importados. Isso é vital para garantir que o áudio seja reproduzido corretamente em builds de jogo exportadas, onde os caminhos de arquivo diretos podem não ser confiáveis.

### Como Gerar/Atualizar o `AudioManifest`:

1.  **Selecione o Nó:** Na sua cena principal (ou em qualquer cena onde o `CafeAudioManager` esteja presente), selecione o nó `CafeAudioManager` na árvore de Cena.
2.  **Localize o Script:** No painel "Sistema de Arquivos" do editor Godot, navegue até `res://addons/CafeAudioManager/scripts/generate_audio_manifest.gd`.
3.  **Abrir no Editor de Script:** Clique com o botão direito em `generate_audio_manifest.gd` e selecione "Abrir no Editor de Script".
4.  **Executar o Script:** Com o script aberto, vá em `Arquivo` -> `Executar Script` (ou pressione `F6`).
5.  **Verificação:** O arquivo `AudioManifest.tres` será gerado ou atualizado e salvo em `res://addons/CafeAudioManager/resources/audio_manifest.tres`. Você deverá ver uma saída no console do Godot indicando o processo de geração do manifest.

**Ponto para Imagem:** Uma imagem mostrando o script `generate_audio_manifest.gd` no editor de script e a opção "Executar Script" seria muito útil.

*   **Importante:** Você deve reexecutar este script sempre que adicionar, remover ou renomear arquivos de áudio em seus diretórios `sfx_root_path` ou `music_root_path` para garantir que o manifest esteja atualizado.

## 2. Caminhos Raiz de Áudio

O `CafeAudioManager` descobre automaticamente os arquivos de áudio dentro dos diretórios raiz especificados. Esses caminhos podem ser configurados no painel Inspetor quando o nó `CafeAudioManager` é selecionado:

*   **`sfx_root_path`**: Esta propriedade define o caminho absoluto para a pasta que contém todos os seus efeitos sonoros.
    *   **Padrão:** `res://addons/CafeAudioManager/assets/sfx/`
    *   **Exemplo:** Se você armazena seus SFX em `res://assets/audio/sfx/`, você definiria esta propriedade para esse caminho.
*   **`music_root_path`**: Esta propriedade define o caminho absoluto para a pasta que contém todas as suas faixas de música.
    *   **Padrão:** `res://addons/CafeAudioManager/assets/music/`
    *   **Exemplo:** Se você armazena suas músicas em `res://assets/audio/music/`, você definiria esta propriedade para esse caminho.

**Ponto para Imagem:** Uma imagem mostrando o Inspetor do nó `CafeAudioManager` com os campos `sfx_root_path` e `music_root_path` destacados seria útil.

### Estrutura dentro dos Caminhos Raiz:

O plugin espera que os arquivos de áudio estejam diretamente dentro desses caminhos raiz ou em subdiretórios. Por exemplo:

```
res://addons/CafeAudioManager/assets/sfx/
├───interface/
│   ├───button_click.ogg
│   └───menu_open.ogg
├───player/
│   ├───jump.ogg
│   └───hit.ogg
```
Nesta estrutura, `button_click`, `menu_open`, `jump` e `hit` seriam reconhecidos como chaves de SFX.