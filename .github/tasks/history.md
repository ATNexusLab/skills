# Tasks — History

## Concluídas

<!-- Formato: - [x] [ID] Descrição — YYYY-MM-DD -->

- [x] [SETUP-001] Estruturar repositório base compatível com npx skills add — 2026-04-07
- [x] [CHORE-001] Transformar repositório de skills em repositório de agentes — 2026-04-08
  - Reescreveu `.system/template/SKILL.md` com spec completa
  - Criou `.system/creating-agents/SKILL.md` (meta-agente)
  - Criou 6 agentes em `.experimental/agents/` (architect, pr-reviewer, principal, security-analyst, specs-collector, test-driven-developer)
  - Criou 10 skills em `.experimental/skills/`
  - Reescreveu `README.md`
  - Atualizou `.github/copilot-instructions.md`
  - Post-mortem: Skills + Custom agents são complementares (skill = workflow, agent = persona). 7 mecanismos de customização do Copilot CLI identificados.
- [x] [CHORE-002] Completar repositório: 9 agentes, refatorar how-to.md, docs, validação — 2026-04-09
  - Criou 9 agentes: backend, frontend, ui-ux-specialist, mobile-expert, sql-dba, nosql-dba, github-operator, performance-analyst, instructions-expert
  - Refatorou `how-to.md` em `docs/architecture.md`, `docs/conventions.md`, `ADR-001`
  - Criou `CONTRIBUTING.md` e `scripts/validate.sh`
  - Atualizou roster do principal (5→14 agentes), README, copilot-instructions
  - Review de produção: corrigiu paths `.github/tasks/`, frontmatter de tools, contagens no README
  - Validação final: 15 agentes ✅, 10 skills ✅
- [x] [FIX-003] Remover paths hardcoded de skills/agents — tornar genéricos — 2026-04-09
  - 7 arquivos corrigidos: architecture-reading, backend-implementation, spec-writing (skills) + backend, architect, security-analyst, specs-collector (agents)
  - Substituiu 15+ referências a `docs/context/` por instruções de discovery genéricas
  - Validação: `scripts/validate.sh` — 15 agents ✅, 10 skills ✅
  - Registrou lição em lessons.md sobre genericidade
- [x] [FEAT-001] Completar roster: 2 agents + 7 skills — 100% padronizado — 2026-04-09
  - Criou 2 agents: devops, documentation-writer
  - Criou 7 skills: code-review, testing-patterns, security-audit, api-design, refactoring, devops-patterns, technical-writing
  - Preencheu 3 gaps de agent→skill: test-driven-developer, security-analyst, pr-reviewer
  - Atualizou: principal (roster), backend (ref api-design), architecture.md (grafo), README, copilot-instructions
  - Validação final: 17 agents ✅, 17 skills ✅, 0 gaps
