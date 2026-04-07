---
name: _template
description: Template interno de referência para criar novas skills
metadata:
  internal: true
---

# Template de Skill

> ⚠️ Esta é uma skill de referência interna. Copie esta estrutura para criar novas skills.

## Estrutura Mínima

Copie esta pasta, renomeie e edite o `SKILL.md`:

```markdown
---
name: nome-da-skill
description: O que a skill faz e quando o agente deve usá-la
---

# Nome da Skill

Instruções detalhadas para o agente seguir quando esta skill for ativada.
```

## Campos do Frontmatter

| Campo | Obrigatório | Descrição |
|-------|-------------|-----------|
| `name` | ✅ | Identificador único (lowercase, hífens permitidos) |
| `description` | ✅ | Explicação curta do propósito da skill |
| `metadata.internal` | ❌ | `true` para ocultar da descoberta padrão |

## Boas Práticas

- Seja específico na `description` — o agente usa ela para decidir quando ativar a skill
- Estruture as instruções em seções claras (## Quando Usar, ## Passos, etc.)
- Prefira instruções acionáveis e objetivas
- Teste a skill antes de mover de `.experimental/` para `.curated/`
