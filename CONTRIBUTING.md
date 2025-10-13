# ☕ Contribuindo para a CafeEngine

Primeiramente, obrigado pelo seu interesse em contribuir para a **CafeEngine**!  
Cada ajuda torna a suíte de plugins mais poderosa e útil para a comunidade Godot.

---

## 📖 Nossa Filosofia de Design

A CafeEngine segue a filosofia de **Programação Orientada a Resources (ROP)**.  
Antes de contribuir, recomendamos a leitura do nosso documento conceitual: [ROP.md](ROP.md).

---

## 🐛 Reportando Bugs

Antes de reportar um bug, **verifique se ele já não foi reportado** na seção de Issues do repositório.

Ao reportar, inclua:

- Versão do Godot e do plugin CafeEngine (ex: StateMachine v1.0, AudioManager v1.1)
- Passos detalhados para reproduzir
- Resultado esperado
- Resultado atual (incluindo mensagens de erro, screenshots, GIFs)

**Checklist para Bug Report:**

- [ ] Versão do Godot:
- [ ] Versão do plugin:
- [ ] Passos para reproduzir:
- [ ] Resultado esperado:
- [ ] Resultado atual:
- [ ] Mensagens de erro / screenshot anexados:

---

## 💡 Sugerindo Melhorias

Se tiver ideias para novas funcionalidades ou melhorias:

1. Abra uma **Issue** no GitHub.
2. Explique **o problema que deseja resolver**.
3. Mostre **como a sugestão seria usada**.
4. Se possível, explique **por que isso melhora a suíte**.

---

## 📝 Guia de Estilo de Código

Para manter o código consistente e legível:

- **Tipagem Estática:** Sempre que possível (`var speed: float = 100.0`)
- **Comentários:** Documente funções complexas e propriedades (`##` para docstrings visíveis no Inspector)
- **Nomenclatura:**
  - Classes/Nodes: PascalCase → `AudioManager`, `StateComponent`
  - Variáveis/Funções: snake_case → `current_state`, `update_audio()`
  - Resources nativos da CafeEngine (opcional): prefixo `CE_` → `CE_StateBehavior`
- **Signals:** siga convenção `changed`, `updated`, `requested`, `completed`
- **Editor Scripts:** use `@tool` quando necessário
- **Properties Exportadas:** use `@export` para que apareçam no Inspector

---

## 🔀 Pull Requests (PR)

Para submeter alterações:

1. **Fork** do repositório.
2. **Crie uma branch** descritiva:
   - Ex: `feature/audiocafe-add-reverb`
   - Ex: `fix/statecafe-null-reference`
3. **Implemente suas alterações**.
4. **Teste tudo**: garanta que nenhuma funcionalidade existente quebre.
5. **Envie o Pull Request** para a branch `main` do repositório principal.
6. **Referencie a Issue** correspondente quando aplicável.

**Checklist antes de PR:**

- [ ] Código testado no editor e em runtime
- [ ] Nenhum erro ou warning no console
- [ ] Comentários/documentação atualizados
- [ ] Segue nomenclatura e estilo da suíte
- [ ] Inclui exemplos ou instruções de uso quando necessário

---

## 🧩 Contribuindo com Novos Plugins

Se deseja criar **novos plugins CafeEngine**:

1. Siga a estrutura padrão:

addons/[plugin_name]/
├── plugin.cfg
├── components/
├── resources/
├── panel/
├── scripts/
├── icons/
└── docs/

2. Registre custom types e painéis via **CoreEngine**.
3. Use Resources para dados, comportamento e configuração.
4. Forneça documentação e exemplos de uso.
5. Teste integração com outros plugins da suíte.

---

## 🙏 Agradecimento

Obrigado por contribuir com a CafeEngine!  
Sua ajuda mantém a suíte viva, moderna e útil para a comunidade Godot.