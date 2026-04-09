# Arquitetura do Sistema de Agentes

## Visão Geral

Este repositório implementa um **sistema cognitivo reutilizável** — um time de IA especializado que pode ser instalado em qualquer projeto via `npx skills add ATNexusLab/skills`.

O sistema é composto por **agents** (decisão) e **skills** (execução), organizados para funcionar de forma cross-model — projetado para Copilot CLI, compatível com Claude Code e outros modelos.

## Conceitos Fundamentais

| Conceito | Definição | Analogia |
|----------|-----------|----------|
| Agent | Entidade que decide **o que fazer** e **quando delegar** | Cérebro |
| Skill | Entidade que define **como executar** algo | Mão |
| Instructions | Regras sempre válidas no contexto | Leis |
| Docs | Fonte da verdade do sistema | Memória |
| Tasks | Memória operacional (estado atual) | Estado |

## Convergência Cross-Model

O sistema converge entre Copilot CLI e Claude Code:

| Conceito | Copilot CLI | Claude Code |
|----------|-------------|-------------|
| Persona | Agent (`.agent.md`) | Agent |
| Procedimento | Skill (`SKILL.md`) | Skill |
| Regras | Instructions (`.instructions.md`) | System / Project Instructions |
| Execução isolada | Subagent (tool `agent`) | Tool use / delegation |
| Orquestração | Agent + tool `agent` | Prompt / multi-agent |

**Diferenças práticas:**

- **Copilot CLI** — usa filesystem fortemente, carrega `.agent.md`, usa tool `agent`, usa `.instructions.md` com `applyTo`
- **Claude Code** — depende mais do prompt, não exige estrutura rígida, lê arquivos como contexto

**Insight principal:**

> Claude não precisa de estrutura. Copilot precisa.
> **Projete para Copilot, e Claude entende de graça.**

## Grafo de Delegação

```text
principal
 ├── architect
 │    ├── spec-writing (skill)
 │    └── architecture-reading (skill)
 ├── specs-collector
 │    └── spec-writing (skill)
 ├── test-driven-developer
 │    └── testing-patterns (skill)
 ├── backend
 │    ├── backend-implementation (skill)
 │    └── api-design (skill)
 ├── frontend
 │    └── frontend-implementation (skill)
 ├── ui-ux-specialist
 │    └── ux-specification (skill)
 ├── mobile-expert
 │    └── mobile-patterns (skill)
 ├── devops
 │    └── devops-patterns (skill)
 ├── sql-dba
 │    └── database-design (skill)
 ├── nosql-dba
 │    └── database-design (skill)
 ├── github-operator
 │    └── github-operations (skill)
 ├── performance-analyst
 │    └── performance-analysis (skill)
 ├── security-analyst
 │    └── security-audit (skill)
 ├── pr-reviewer
 │    └── code-review (skill)
 ├── documentation-writer
 │    └── technical-writing (skill)
 ├── instructions-expert
 │    └── copilot-instructions (skill)
 ├── web-researcher
 │    └── web-research (skill)
 └── marketing-specialist
      └── growth-marketing (skill)

Skills transversais (referenciadas por múltiplos agentes):
 ├── api-design
 └── refactoring
```

## Regras de Design

### Agent Design

- Agent responde: **quando agir**, **como pensar**, **quando delegar**
- Tamanho ideal: 50–150 linhas
- NÃO é: biblioteca, tutorial, checklist
- Deve ser pequeno, focado, sem execução pesada

### Skill Design

- Skill responde: **como executar algo**
- Tamanho ideal: 100–300 linhas
- NÃO é: persona, orquestrador
- Execução sempre via skill (skill-first execution)

### Regras de Delegação

- Delegar quando aumenta qualidade
- Evitar loops
- Evitar over-delegation
- Consolidar no final

### Single Source of Truth

| O quê | Onde |
|-------|------|
| Regras | Instructions (nunca duplicar) |
| Conhecimento | Docs (nunca duplicar) |
| Execução | Skills (nunca duplicar) |

## Anti-Patterns (Erros Fatais)

| Anti-Pattern | Por quê é fatal |
|--------------|-----------------|
| ❌ Misturar agent + skill | Agent decide, skill executa — nunca ambos |
| ❌ Criar agent para tudo | Skill resolve a maioria dos casos |
| ❌ Duplicar lógica entre agents | Extrair para skill compartilhada |
| ❌ Criar contexto por agent | Contexto é centralizado em docs |
| ❌ Agents gigantes | Quebrar em skill se crescer |
| ❌ Skills gigantes sem modularidade | Dividir em skills menores e compostas |

## Memória e Contexto

| Tipo | Lugar |
|------|-------|
| Arquitetura | `docs/context` |
| Decisões | `docs/context/decisions` |
| Estado atual | `.github/tasks` |
| Regras | `.github/copilot-instructions.md`, `.github/instructions/` |

**NÃO fazer:** memória por agent, histórico distribuído.

## Estrutura de Diretórios

```text
.github/
  copilot-instructions.md
  instructions/
    *.instructions.md
  agents/
    principal.agent.md
    architect.agent.md
    ...
  tasks/
    todo.md
    history.md
    lessons.md

skills/
  .system/          # templates e skills de sistema
  .experimental/    # em desenvolvimento
  .curated/         # validado em produção

docs/
  architecture.md   # este arquivo
  conventions.md    # padrões e nomenclatura
  context/
    decisions/      # ADRs
```

## Evolução

| Fase | Foco | Descrição |
|------|------|-----------|
| 1 | Funcionar | Poucos agents + poucas skills |
| 2 | Eficiência | Delegação refinada |
| 3 | Sabedoria | Extração de padrões recorrentes |
