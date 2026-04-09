---
name: copilot-instructions
description: Use quando precisar criar ou atualizar instruções do Copilot CLI — copilot-instructions.md, SKILL.md, .agent.md ou arquivos de instrução por caminho.
type: skill
targets: [copilot-cli]
---

# Copilot Instructions

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Tipos de Instrução Copilot CLI

| Tipo | Arquivo | Escopo |
|------|---------|--------|
| Global | `~/.copilot/instructions.md` | Todas as sessões do usuário |
| Repositório | `.github/copilot-instructions.md` | Todo o repositório |
| Por caminho | `.github/instructions/*.instructions.md` com `applyTo` no frontmatter | Arquivos específicos |
| Skill | `skills/<name>/SKILL.md` | Carregada sob demanda por agente |
| Agent | `agents/<name>.agent.md` | Contexto isolado do subagente |

## Formato: copilot-instructions.md

Arquivo de instruções globais do repositório. Deve definir:

```markdown
# [Nome do Projeto] — Copilot Instructions

## Contexto
[O que é o projeto, stack principal, idioma de resposta]

## Convenções
[Convenções de código, nomenclatura, padrões obrigatórios]

## Protocolo de Resposta
[Como o agente deve trabalhar — etapas, aprovação, registro]

## Roster de Agentes
[Tabela de agentes disponíveis e quando chamar cada um]

## Nunca Faça
[Anti-padrões explícitos para este repositório]
```

## Formato: SKILL.md

Conhecimento procedural reutilizável. Frontmatter obrigatório:

```yaml
---
name: skill-name
description: Quando usar esta skill em uma frase precisa.
type: skill
targets: [copilot-cli]
---
```

Corpo do SKILL.md deve conter:
- **Quando Usar** — gatilhos precisos
- **Checklist ou Workflow** — passo-a-passo executável
- **Padrões** — código de referência, exemplos
- **Nunca Faça** — anti-padrões explícitos

## Formato: .agent.md

Persona isolada com contexto próprio. Frontmatter obrigatório:

```yaml
---
name: agent-name
description: [Persona]. Use quando [gatilho preciso].
tools: ["read", "search", "edit"]
---
```

Regras críticas para `.agent.md`:
- **Deve ser COMPLETO** — persona + workflow + nunca-faz + protocolo de escalamento
- **Sem ponteiros** — não escrever "use a skill X para detalhes"; incorporar o essencial inline
- **Ferramentas mínimas** — listar só as tools que o agente realmente precisa
- **Persona forte** — o agente deve ter uma voz e perspectiva clara

Corpo do `.agent.md` deve conter:
- Identidade e papel
- Perguntas de discovery (se aplicável)
- Workflow passo-a-passo
- Protocolo de escalamento
- O que nunca fazer

## Formato: Path-Specific Instructions

```yaml
---
applyTo: "**/*.test.ts"
---

# Instruções para arquivos de teste TypeScript

[Convenções específicas para este tipo de arquivo]
```

## Quando Usar Cada Tipo

| Cenário | Tipo de instrução |
|---------|------------------|
| Convenções globais do projeto | `copilot-instructions.md` |
| Regras para um tipo de arquivo específico | Path-specific `.instructions.md` |
| Conhecimento de domínio reutilizável | `SKILL.md` |
| Persona com workflow completo | `.agent.md` |

## Checklist de Qualidade

Para qualquer instrução criada:
- [ ] Frontmatter com `name` e `description` preenchidos
- [ ] Conteúdo em pt-BR (padrão deste repositório)
- [ ] Sem TODO ou placeholder vazio no conteúdo
- [ ] Instruções executáveis, não só conceituais
- [ ] Sem repetição de conteúdo já em outra instrução
- [ ] Tag `⚠️ EXPERIMENTAL` se ainda não validado em produção
