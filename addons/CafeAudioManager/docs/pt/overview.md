# Visão Geral do CafeAudioManager

O plugin `CafeAudioManager` foi desenvolvido para ser um sistema de gerenciamento de áudio robusto e desacoplado para projetos Godot Engine. Ele substitui o sistema de áudio padrão, frequentemente encontrado em templates como "Café Essentials - Godot Brew Kit", e atua como um EventBus dedicado para todas as comunicações relacionadas a áudio. Isso centraliza a lógica de áudio, tornando-a mais fácil de gerenciar em todo o seu jogo.

## Principais Funcionalidades:

*   **Carregamento Dinâmico de Áudio:** O plugin escaneia e carrega automaticamente arquivos de áudio de diretórios configuráveis, categorizando-os em bibliotecas de efeitos sonoros (SFX) e música. Isso elimina a necessidade de pré-carregar manualmente cada recurso de áudio.
*   **Pool de Reprodutores de SFX:** Utiliza um pool configurável de instâncias de `AudioStreamPlayer` para reproduzir efeitos sonoros. Isso evita o corte de áudio quando múltiplos SFX são reproduzidos simultaneamente e otimiza o desempenho através da reutilização de reprodutores.
*   **Gerenciamento de Playlists de Música:** Oferece um gerenciamento abrangente para música, incluindo a capacidade de definir playlists, reproduzir faixas aleatoriamente dentro de uma categoria e lidar com transições automáticas ou manuais entre as músicas.
*   **Controle de Volume Desacoplado:** Proporciona uma maneira limpa de controlar o volume de diferentes buses de áudio (ex: Master, Música, SFX) sem dependências diretas, promovendo uma arquitetura modular.
*   **Compatibilidade com Builds Exportadas:** Garante que sua configuração de áudio funcione perfeitamente em builds de jogo exportadas, utilizando um `AudioManifest` para referenciar recursos de áudio através de seus IDs únicos (UIDs).

## Limitações:

*   **Apenas Áudio Mono:** Este AudioManager é projetado exclusivamente para áudio mono. Atualmente, não oferece suporte para efeitos de áudio posicional 2D ou 3D. Se o seu projeto exigir áudio espacial, você pode precisar integrar nós `AudioStreamPlayer2D` ou `AudioStreamPlayer3D` adicionais e gerenciar sua reprodução separadamente, ou considerar estender a funcionalidade deste plugin.