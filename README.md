# Copilot Instructions — ATNexusLab Skills

Repositório central de skills da organização **ATNexusLab**, compatível com o ecossistema [skills.sh](https://skills.sh).  
Skills são instaladas em qualquer projeto com um único comando:

```sh
npx skills add ATNexusLab/skills
```

---

## Estrutura do Repositório

```
skills/
├── .curated/       # Skills estáveis, prontas para produção
├── .experimental/  # Skills em desenvolvimento ou validação
└── .system/        # Skills internas (não aparecem publicamente)
```

Cada skill é uma **pasta** contendo obrigatoriamente um `SKILL.md` com frontmatter YAML:

```markdown
---
name: nome-da-skill
description: Uma frase clara e objetiva do que a skill faz e quando usar.
---

# Conteúdo da skill...
```

> `name` e `description` são obrigatórios. A `description` é usada pelo agente para decidir quando carregar a skill — escreva com precisão.

---

## Protocolo de Resposta (Obrigatório em Todas as Mensagens)

Este protocolo é **mandatório** e deve ser seguido literalmente em toda mensagem recebida, sem exceção.

### Fluxo (9 Etapas)

1. **Ler a solicitação** — Interpretar com precisão o que foi pedido.
2. **Consultar conhecimentos relevantes** — Nesta ordem:
   - `.github/tasks/todo.md` (backlog atual)
   - `.github/tasks/history.md` (contexto de entregas anteriores)
   - `copilot-instructions.md` (regras vigentes)
   - `lessons.md` (lições acumuladas — ler índice primeiro, ir à categoria relevante)
   - Skill `skill-creator` se a tarefa envolver criar ou modificar skills
3. **Definir specs e apresentar o plano** — Detalhar escopo, nome da skill, propósito, estrutura do `SKILL.md` e critérios de aceite. O plano **nunca** existe em memória de sessão — após aprovação, é escrito imediatamente no `todo.md`. Nenhum arquivo `plan.md` deve ser criado.
4. **Aguardar aprovação explícita** — Nenhuma ação ocorre sem confirmação. Se recusado, replanejar.
5. **Registrar no `todo.md`** — Inserir a task aprovada usando o modelo padrão.
6. **Escrever a skill** — Com o plano aprovado e registrado, implementar o `SKILL.md` seguindo as regras de qualidade abaixo.
7. **Mover concluídos para `history.md`** — Antes de qualquer nova task, mover todos os itens `[x]` do `todo.md` para `history.md`. Nunca acumular itens concluídos no `todo.md`.
8. **Atualizar documentação** — Ao finalizar: atualizar `README.md` se necessário e `lessons.md`.
9. **Relatório final** — Resumo do que foi feito e arquivos criados ou modificados.

> Quando o usuário corrigir um erro, registrar **imediatamente** o aprendizado em `lessons.md`.

---

## Regras de Qualidade para Skills

Uma skill só está pronta quando atende **todos** os critérios abaixo:

- `name` em `kebab-case`, sem prefixos genéricos como `skill-` ou `my-`.
- `description` responde à pergunta: *"quando devo carregar esta skill?"* — sem ambiguidade.
- O corpo do `SKILL.md` é **instrucional e acionável** — diz ao agente o que fazer, não o que é.
- Sem informações duplicadas com outras skills do repositório.
- Skills `.curated/` passaram por pelo menos um uso real em produção antes de mover.
- Skills `.experimental/` têm uma nota no topo indicando seu status.

---

## Git — Fluxo de Trabalho

Seguir as convenções padrão de Git e GitHub para nomenclatura de branches, commits e PRs.

- **Branches:** prefixo convencional (`feat/`, `fix/`, `refactor/`, `chore/`).
- **Commits:** Conventional Commits obrigatório (`feat:`, `fix:`, `docs:`, `chore:`).
- **Push:** empurrar quando o trabalho da branch estiver coeso, sem push por sub-etapa.
- **PR:** abrir somente quando a entrega estiver concluída. Nunca abrir PR com trabalho em andamento.

---

## Task Management

### `tasks/todo.md` — Backlog oficial

- Fonte de verdade.
- Sempre ler o estado atual antes de qualquer alteração.
- Nunca sobrescrever conteúdo existente sem leitura prévia.
- Itens `[x]` devem ser movidos para `history.md` antes de qualquer nova adição.

### `tasks/history.md` — Registro permanente

- Destino de todos os itens concluídos removidos do `todo.md`.
- Nunca apagar entradas existentes — apenas acrescentar ao final.

### `lessons.md` — Conhecimento acumulado

- Registrar padrões descobertos e erros corrigidos imediatamente após ocorrência.
- Manter um **índice no topo** com número de linha por categoria.
- Ao consultar, ler o índice primeiro e ir direto à categoria relevante.

**Estrutura:**

```markdown
# Lessons — Índice

- [SKILL-QUALITY] linha X
- [ESTRUTURA] linha X
- [GIT] linha X

---

## [CATEGORIA]

- [YYYY-MM-DD]: Descrição do padrão ou erro e como evitar.
```

### Tipos de Task

| Prefixo | Significado |
|---------|-------------|
| `[SKILL]` | Criar ou refatorar uma skill |
| `[FIX]` | Corrigir skill com comportamento incorreto |
| `[MOVE]` | Promover skill de `.experimental/` para `.curated/` |
| `[DOCS]` | Atualizar `README.md` ou documentação |
| `[CHORE]` | Manutenção do repositório |

### Modelo — `todo.md`

```markdown
# Tarefa: [PREFIXO] Nome da Task

## Specs
- Skill: [nome-da-skill]
- Destino: [.curated | .experimental | .system]
- Propósito: [o que a skill ensina o agente a fazer]
- Critérios de aceite: [como saber que está pronta]

## Plano
- [ ] Etapa 1: Redigir `SKILL.md` com frontmatter e conteúdo
- [ ] Etapa 2: Validar critérios de qualidade
- [ ] Etapa 3: Atualizar `README.md` se necessário

## Post-Mortem
- [Notas sobre ajustes ou débitos]
```

---

## Regras — Nunca Faça

- **Nunca** crie uma skill sem o frontmatter YAML completo (`name` + `description`).
- **Nunca** mova uma skill para `.curated/` sem uso real validado.
- **Nunca** crie `plan.md` — o plano aprovado vai direto para o `todo.md`.
- **Nunca** abra PR com trabalho em andamento.
- **Nunca** acumule itens `[x]` no `todo.md`.

---

**Última atualização:** Abril 2026 | **Versão:** 1.0.0 | **Repositório:** ATNexusLab/skills