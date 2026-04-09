---
name: creating-agents
description: Use quando precisar criar um novo agente ou skill para este repositório. Guia o processo completo: requisitos, estrutura de pastas, SKILL.md e .agent.md.
---

<required>
*CRÍTICO* Adicione os seguintes passos à sua lista de Todos antes de começar:
1. Coletar requisitos: nome, propósito, ferramentas necessárias, quando será chamado
2. Decidir tipo: `agent` (persona com workflow) ou `skill` (capacidade específica)
3. Criar pasta em `skills/.experimental/agents/` ou `skills/.experimental/skills/`
4. Escrever `SKILL.md` com frontmatter e seções completas
5. (Se agent) Escrever `NOME.agent.md` com ferramentas restritas ao papel
6. Revisar contra o template em `skills/.system/template/SKILL.md`
</required>

# Creating Agents

## O Ecossistema de Customização

Este repositório usa o padrão do Copilot CLI. Cada agente tem dois arquivos:

| Arquivo | Propósito |
|---------|-----------|
| `SKILL.md` | Workflow detalhado, carregado just-in-time como skill |
| `NOME.agent.md` | Template de custom agent, copiado para `.github/agents/` no projeto |

## Tipos de Instrução do Copilot CLI

| Tipo | Arquivo | Escopo |
|------|---------|--------|
| Global pessoal | `~/.copilot/copilot-instructions.md` | Todos os projetos |
| Repo | `.github/copilot-instructions.md` | Um projeto |
| Path-specific | `.github/instructions/*.instructions.md` | Glob de arquivos |
| Agent instructions | `AGENTS.md` | Complementar ao repo |
| Skill | `SKILL.md` em `skills/` | Just-in-time por relevância |
| Custom agent | `NOME.agent.md` em `.github/agents/` ou `~/.copilot/agents/` | Contexto próprio |

## Fluxo de Criação

### 1. Definir Requisitos
Perguntas obrigatórias antes de criar:
- Qual é o gatilho preciso para chamar este agente?
- Quais ferramentas são necessárias? (restringir ao mínimo)
- Quais são as 4-6 etapas do workflow principal?
- Quais são as proibições inegociáveis?

### 2. Escolher Tipo
- **Agent**: tem persona, workflow multi-etapa, contexto isolado → cria SKILL.md + .agent.md
- **Skill**: capacidade específica sem persona forte → cria apenas SKILL.md

### 3. Escrever SKILL.md
Seguir o template em `skills/.system/template/SKILL.md`. Campos obrigatórios:
```yaml
name: nome-em-kebab-case
description: Use quando [gatilho preciso]. [Uma frase do que faz.]
```

### 4. Escrever .agent.md
```yaml
name: nome-do-agente
description: [Persona]. Use quando [gatilho].
tools: ["read", "search", "edit"]  # restringir ao mínimo necessário
user-invocable: true
```

### 5. Revisar
- `<required>` tem 4-6 passos acionáveis e específicos?
- Seções: Persona, Protocolo de Escalonamento, Fluxo, Ferramentas, Nunca Faça
- Ferramentas restritas ao mínimo necessário para o papel?
- Linguagem em português (pt-BR)?

## Referência de Ferramentas por Papel

| Papel | Tools recomendados |
|-------|--------------------|
| Reviewers (PR, Security) | `["read", "search", "todo"]` |
| Analistas (Architect, UX) | `["read", "search", "edit", "todo"]` |
| Implementadores (Backend, Frontend, TDD) | `["read", "search", "edit", "execute", "todo"]` |
| Operadores (GitHub) | `["read", "search", "execute", "todo"]` |

## Nunca Faça

- Nunca criar um agente sem o `<required>` block com passos concretos.
- Nunca deixar `description` vaga — deve conter o gatilho preciso.
- Nunca dar acesso a `execute` para agentes read-only (reviewers, analistas).
- Nunca criar agente com sobreposição de responsabilidade sem definir fronteira clara.
