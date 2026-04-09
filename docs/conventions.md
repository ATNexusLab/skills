# Convenções do Repositório

## Nomenclatura

- Nomes de agentes e skills: `kebab-case` (ex: `test-driven-developer`, `backend-implementation`)
- Nome no frontmatter DEVE corresponder ao nome do diretório/arquivo
- Idioma de TODO conteúdo: Português (pt-BR)

## Estrutura de Frontmatter

### SKILL.md (obrigatório)

| Campo | Obrigatório | Descrição |
|-------|-------------|-----------|
| `name` | ✅ | 1-64 chars, kebab-case, deve corresponder ao diretório |
| `description` | ✅ | 1-1024 chars, o que faz e quando usar |
| `type` | Recomendado | `agent` ou `skill` |
| `targets` | Recomendado | `[copilot-cli]` ou outros |
| `license` | Recomendado | `MIT` |
| `compatibility` | Opcional | Requisitos de runtime |

### .agent.md (obrigatório)

| Campo | Obrigatório | Descrição |
|-------|-------------|-----------|
| `name` | ✅ | kebab-case, deve corresponder ao nome da skill |
| `description` | ✅ | Papel + quando usar |
| `tools` | ✅ | Lista de ferramentas permitidas |
| `user-invocable` | Recomendado | `true` para aparecer no dropdown de chat |
| `disable-model-invocation` | Recomendado | `false` para permitir uso como subagente |

## Tamanhos Ideais

| Tipo | Linhas | Justificativa |
|------|--------|---------------|
| Agent (.agent.md) | 50–150 | Persona, delegação e workflow — nada mais |
| Skill (SKILL.md) | 100–300 | Procedimento detalhado com exemplos |

## Seções Obrigatórias de um Agent

1. Persona (1-3 linhas)
2. Metodologia ou Framework específico do domínio
3. Protocolo de Escalamento
4. Fluxo de Trabalho (passos numerados)
5. Nunca Faça (proibições explícitas)

## Seções Obrigatórias de uma Skill

1. Frontmatter YAML
2. Quando Usar
3. Passos/Procedimento
4. Exemplos ou Templates
5. Checklist de validação

## Ciclo de Vida

```text
experimental → uso em projetos reais → validação → curated
```

- `.experimental/`: em desenvolvimento, pode mudar
- `.curated/`: estável, validado em produção
- NUNCA mover para curated sem uso real validado

## Ferramentas por Papel

| Papel | Tools |
|-------|-------|
| Somente leitura | `read`, `search`, `todo` |
| Leitura + escrita | `read`, `search`, `edit`, `todo` |
| Execução | `read`, `search`, `edit`, `execute`, `todo` |
| Orquestração | `read`, `search`, `edit`, `todo`, `agent` |
