# Constituição da Documentação do CafeEngine

**Status:** Constitucional
**Documento:** `docs/laws_constitution/documentation.md`

---

### **Preâmbulo**

Uma documentação clara, precisa e acessível é um pilar fundamental de toda a suíte CafeEngine. Esta lei estabelece os padrões e processos para a criação e manutenção de toda a documentação do projeto.

### **Artigo I: Padrão de Estilo e Formato**

1.  **Formato:** Toda a documentação deve ser escrita em formato **Markdown (`.md`)**.
2.  **Linguagem:** A linguagem deve ser clara, objetiva e profissional, mas acessível a desenvolvedores de todos os níveis de habilidade.
3.  **Estrutura:** Documentos devem ser bem estruturados com títulos, subtítulos, listas e blocos de código para facilitar a leitura.

### **Artigo II: Documentação por Plugin**

Cada plugin da suíte **DEVE** ter seu próprio subdiretório dentro da pasta `docs/`, contendo, no mínimo:
1.  **Guia de Referência:** Documentos que descrevem em detalhes o que cada componente do plugin *é* e quais são suas funcionalidades.
2.  **Tutoriais:** Guias passo a passo que ensinam *como fazer* tarefas específicas com o plugin.

### **Artigo III: Processo de Atualização**

Fica estabelecido que qualquer alteração no código de um plugin que impacte sua funcionalidade, API ou o fluxo de trabalho do usuário **DEVE, obrigatoriamente, ser acompanhada de uma atualização correspondente na sua documentação relevante**. Nenhuma funcionalidade é considerada "concluída" até que esteja devidamente documentada.
