# Copilot Instructions

## Protocolo de Resposta Padrão (9 Etapas Obrigatórias)

Este protocolo deve ser seguido **literalmente em TODA mensagem recebida**, sem exceção.

---

### Etapas

| # | Ação | Detalhe |
|---|------|---------|
| 1 | **Receber mensagem** | — |
| 2 | **Consultar conhecimentos relevantes** | Ler: `todo.md`, `history.md`, `copilot-instructions.md`, `docs/**`, `lessons.md`, skills relevantes |
| 3 | **Planejar e apresentar** | Mostrar plano detalhado ao usuário antes de agir |
| 4 | **Aguardar aprovação explícita** | Sem aprovação, **não executar** |
| 5 | **Registrar task no todo.md** | Após aprovação, adicionar entry no `.github/tasks/todo.md` |
| 6 | **Migrar tasks finalizadas** | Mover tasks com `[x]` do `todo.md` para o `history.md` |
| 7 | **Executar na ordem do todo.md** | Seguir a ordem definida |
| 8 | **Atualizar documentação** | Atualizar `docs/**`, `todo.md`, `lessons.md` ao finalizar |
| 9 | **Relatório final** | Apresentar o que foi feito e quais conhecimentos foram utilizados |

> **OBS:** Toda vez que o usuário corrigir um erro do agente, inserir o conhecimento imediatamente no `lessons.md`.

---

## Contexto do Repositório

Este é o repositório de skills da organização **ATNexusLab**, compatível com o CLI [vercel-labs/skills](https://github.com/vercel-labs/skills).

**Comando de instalação:**
```sh
npx skills add ATNexusLab/skills
bunx skills add ATNexusLab/skills
```

**Estrutura de skills:**
- `skills/.curated/` — Skills estáveis, prontas para produção
- `skills/.experimental/` — Skills em desenvolvimento
- `skills/.system/` — Skills internas (não aparecem por padrão)

Cada skill é uma pasta contendo um `SKILL.md` com frontmatter YAML (`name` e `description` obrigatórios).

---

## Arquivos de Referência

| Arquivo | Propósito |
|---------|-----------|
| `.github/tasks/todo.md` | Tasks pendentes e em andamento |
| `.github/tasks/history.md` | Tasks concluídas |
| `lessons.md` | Lições aprendidas |
| `README.md` | Documentação pública do repositório |
