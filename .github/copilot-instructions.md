# Copilot Instructions — ATNexusLab/skills

## Contexto

Este é o **repositório de agentes e skills** da organização ATNexusLab.  
Propósito: manter um time de IA reutilizável, instalável em qualquer projeto via `npx skills add ATNexusLab/skills`.

**Stack deste repositório:** Markdown, YAML frontmatter, Bash (scripts opcionais de agents).  
**Idioma de todo conteúdo:** Português (pt-BR).

Para tarefas complexas que envolvam múltiplas especialidades, o ponto de entrada é o agente `principal`.

---

## Nunca Faça

- **Nunca** crie agente/skill sem frontmatter YAML completo (`name` + `description`).
- **Nunca** mova para `.curated/` sem uso real validado em produção.
- **Nunca** acumule itens `[x]` no `todo.md` — mover para `history.md` antes de nova task.
- **Nunca** abra PR com trabalho em andamento.

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
