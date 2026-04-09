---
name: spec-writing
description: Use quando precisar documentar uma decisão arquitetural, especificar um componente novo ou registrar análise técnica. Produz ADR, Tech Spec ou Architecture Notes baseado no impacto.
---

# Spec Writing

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Para registrar decisões arquiteturais importantes (ADR)
- Para especificar um componente novo ou redesign significativo (Tech Spec)
- Para documentar análises, clarificações ou decisões menores (Architecture Notes)
- Sempre que uma decisão precisar ser comunicada a outros agentes ou ao time

## Escolhendo o Formato

| Formato | Quando usar | Critério de impacto |
|---------|-------------|---------------------|
| **ADR** | Decisão cross-cutting, difícil de reverter, longo prazo | Afeta múltiplos módulos ou todo o sistema |
| **Tech Spec** | Componente novo, redesign significativo, integração externa | Afeta um módulo ou serviço específico |
| **Architecture Notes** | Análises, clarificações, padrões, pequenas decisões | Afeta uma área localizada |

**Regra prática:** se você hesitou mais de 5 minutos na decisão, é ADR ou Tech Spec.

## Passos

### 1. Determinar o formato

Com base no critério acima, escolher ADR, Tech Spec ou Architecture Notes.

### 2. Determinar onde salvar

```
docs/context/decisions/   ← ADRs (numerados: 0001-nome-da-decisao.md)
docs/context/             ← Tech Specs e Architecture Notes
```

Se a pasta não existir, criar com um `.gitkeep` e documentar a estrutura.

### 3. Redigir o documento

Usar o template correspondente em `references/`:
- `adr-template.md` → para ADRs
- `tech-spec-template.md` → para Tech Specs
- `architecture-notes-template.md` → para Architecture Notes

### 4. Registrar alternativas rejeitadas

**Obrigatório em qualquer formato:** documentar as alternativas consideradas e por que foram rejeitadas.
Sem isso, a decisão não tem contexto histórico e tende a ser revertida por erro no futuro.

### 5. Comunicar o output

Informar ao agente orquestrador:
- Qual arquivo foi criado/atualizado
- O que mudou
- Quais outros agentes precisam ser informados
- Se outros documentos em `docs/context/` precisam ser atualizados

## Referências

- `references/adr-template.md` — template de ADR
- `references/tech-spec-template.md` — template de Tech Spec
- `references/architecture-notes-template.md` — template de Architecture Notes
- `examples/` — exemplos preenchidos de cada formato
- `patterns/common-patterns.md` — catálogo de padrões arquiteturais para referência
