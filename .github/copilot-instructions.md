# Copilot Instructions — ATNexusLab/skills

## Contexto

Este é o **repositório de agentes e skills** da organização ATNexusLab.  
Propósito: manter um time de IA reutilizável, instalável em qualquer projeto via `npx skills add ATNexusLab/skills`.

**Stack deste repositório:** Markdown, YAML frontmatter, Bash (scripts opcionais de agents).  
**Idioma de todo conteúdo:** Português (pt-BR).

---

## Protocolo de Resposta (9 Etapas — Obrigatório)

| # | Ação |
|---|------|
| 1 | Receber mensagem |
| 2 | Consultar: `todo.md`, `history.md`, `lessons.md`, skills relevantes |
| 3 | Planejar e apresentar ao usuário |
| 4 | Aguardar aprovação explícita — sem aprovação, não executar |
| 5 | Registrar task no `todo.md` |
| 6 | Migrar tasks `[x]` do `todo.md` para `history.md` |
| 7 | Executar na ordem do `todo.md` |
| 8 | Atualizar `lessons.md` e documentação |
| 9 | Relatório final |

> Quando o usuário corrigir um erro, registrar **imediatamente** em `lessons.md`.

---

## Roster de Agentes

Quando a tarefa exigir especialidade, delegar ao agente correspondente:

| Agente | Quando Chamar |
|--------|---------------|
| `specs-collector` | Levantar requisitos antes de qualquer implementação |
| `architect` | Decisões técnicas, tradeoffs, ADRs |
| `test-driven-developer` | Implementação com cobertura TDD |
| `backend` | APIs, serviços, integrações de servidor |
| `frontend` | Componentes, páginas, interfaces web |
| `ui-ux-specialist` | Spec de UX, fluxos, acessibilidade |
| `mobile-expert` | Features mobile, builds, plataforma |
| `devops` | CI/CD, Docker, IaC, pipelines, deploys |
| `sql-dba` | Schemas SQL, migrations, queries |
| `nosql-dba` | Modelagem NoSQL, padrões de acesso |
| `pr-reviewer` | Review de PRs (segurança, lógica, testes) |
| `security-analyst` | Auditoria OWASP, CVEs, secrets |
| `github-operator` | Operações GitHub CLI/API |
| `performance-analyst` | Profiling, benchmarks, otimizações |
| `documentation-writer` | READMEs, guias, API docs, changelogs |
| `instructions-expert` | Criar/atualizar instruções Copilot CLI |
| `project-setup` | Setup inicial de qualquer projeto novo |

---

## Protocolo de Escalonamento

Quando bloqueado, qualquer agente deve:
1. **Parar** — não tomar decisões arbitrárias.
2. Declarar: "Bloqueado em [X]. Contexto: [Y]. Necessito de [agente Z]."
3. **Reportar ao `principal`** a necessidade e aguardar que ele coordene o próximo passo.

> Findings de segurança críticos: reportar ao `principal` imediatamente com detalhes do finding.

---

## Protocolo de Reunião (Multi-Agent)

Para tarefas complexas que requerem múltiplas especialidades:
1. `principal` recebe o problema e cria plano no `todo.md`.
2. Delega sequencialmente aos agentes relevantes via subagents.
3. Cada agente entrega seu resultado antes do próximo iniciar.
4. `principal` sintetiza e reporta ao usuário.

---

## Nunca Faça

- **Nunca** crie agente/skill sem frontmatter YAML completo (`name` + `description`).
- **Nunca** mova para `.curated/` sem uso real validado em produção.
- **Nunca** acumule itens `[x]` no `todo.md` — mover para `history.md` antes de nova task.
- **Nunca** abra PR com trabalho em andamento.
- **Nunca** tome decisões de arquitetura sem reportar ao `principal` — ele acionará o `architect`.
- **Nunca** implemente sem spec — reportar ao `principal` para acionar `specs-collector` primeiro.

---

## Arquivos de Referência

| Arquivo | Propósito |
|---------|-----------|
| `.github/tasks/todo.md` | Tasks pendentes e em andamento |
| `.github/tasks/history.md` | Tasks concluídas |
| `.github/tasks/lessons.md` | Lições aprendidas |
| `docs/architecture.md` | Princípios, delegation graph, regras de design |
| `docs/conventions.md` | Nomenclatura, frontmatter, ciclo de vida |
| `skills/.system/template/SKILL.md` | Spec completa para criar agentes/skills |
| `skills/.system/creating-agents/SKILL.md` | Guia para criar novos agentes |
