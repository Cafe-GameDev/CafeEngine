# Como Contribuir para o CafeEngine

Primeiramente, obrigado pelo seu interesse em contribuir para o **CafeEngine**! Toda ajuda é bem-vinda para tornar esta suíte de plugins uma ferramenta ainda melhor para a comunidade Godot.

## Roadmap de Desenvolvimento

Antes de contribuir, é uma boa ideia se familiarizar com nosso [Roadmap Geral da Suíte CafeEngine](roadmap.md) e com o plano de desenvolvimento para cada plugin. Você pode encontrar os documentos de design nas respectivas pastas `docs/` de cada addon (ex: `addons/statecafe/docs/plugin_design_document.md`).

## Nossa Filosofia de Design

Para entender a base conceitual por trás da CafeEngine, recomendamos a leitura do nosso documento sobre [Programação Orientada a Resources (ROP)](ROP.md).

## Reportando Bugs

* **Verifique se o bug já não foi reportado:** Pesquise na seção de "Issues" do nosso repositório no GitHub.
* **Seja claro e descritivo:** No seu relatório, inclua:

  * A versão do Godot e do plugin **CafeEngine** que você está usando (ex: StateCafe v1.0, AudioCafe v1.1).
  * Passos exatos para reproduzir o bug.
  * O que você esperava que acontecesse.
  * O que de fato aconteceu (incluindo mensagens de erro, screenshots, etc.).

## Sugerindo Melhorias

* Abra uma nova "Issue" para descrever sua sugestão.
* Explique o problema que sua sugestão resolve e por que ela seria útil para a suíte de plugins.
* Se possível, dê exemplos de como a nova funcionalidade seria usada.

## Guia de Estilo de Código

Para manter o código consistente e legível, por favor, siga estas diretrizes:

* **Tipagem Estática:** Use tipagem estática em GDScript sempre que possível (`var speed: float = 100.0`).
* **Comentários:** Comente o propósito de funções e propriedades complexas. Use os comentários de documentação (`##`) para descrever o que uma propriedade faz no Inspector.
* **Nomenclatura:** Siga as convenções de nomenclatura do Godot (PascalCase para classes e nós, snake_case para variáveis e funções).

## Processo de Pull Request (PR)

1. **Fork o Repositório:** Crie um fork do projeto para a sua conta do GitHub.
2. **Crie uma Branch:** Crie uma branch descritiva para a sua alteração (ex: `feature/audiocafe-add-reverb` ou `fix/statecafe-null-reference`).
3. **Faça suas Alterações:** Implemente sua funcionalidade ou correção de bug.
4. **Teste:** Garanta que suas alterações não quebram nenhuma funcionalidade existente.
5. **Envie o Pull Request:** Submeta um PR para a branch `main` do repositório principal. Na descrição, explique claramente o que você fez e por quê.

Obrigado novamente pela sua contribuição!
