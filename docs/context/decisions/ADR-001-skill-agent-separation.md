# ADR-001: Separação entre SKILL.md e .agent.md

## Status

Aceito — 2025-04-07

## Contexto

Ao estruturar o repositório de agentes, precisávamos decidir como organizar as instruções de cada agente.

## Decisão

Cada agente tem dois arquivos separados:

- **SKILL.md** — Workflow detalhado, carregado automaticamente como skill
- **.agent.md** — Template de custom agent com persona e delegação

## Alternativas Rejeitadas

### Tudo em um arquivo só

- Prós: simplicidade
- Contras: `.agent.md` tem limite de contexto; mistura persona com procedimento; não compatível com `npx skills add`

### Só SKILL.md sem .agent.md

- Prós: compatível com skills.sh
- Contras: sem delegação multi-agent; sem persona com contexto próprio; perde o poder de custom agents

## Consequências

- Skills são instaláveis via `npx skills add` e carregadas automaticamente
- Agents precisam ser copiados manualmente para `.github/agents/`
- Manutenção de 2 arquivos por agente (overhead aceitável)
