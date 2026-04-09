# Contribuindo com ATNexusLab/skills

## Pré-requisitos

- Node.js 18+
- Git
- GitHub CLI (`gh`)

## Instalar Skills em um Projeto

```sh
npx skills add ATNexusLab/skills
```

## Criar um Novo Agente

1. Use a skill `creating-agents` (disponível após install) ou siga o template em `skills/.system/template/SKILL.md`
2. Crie a pasta em `skills/.experimental/agents/[nome-do-agente]/`
3. Crie `SKILL.md` com frontmatter completo (name + description obrigatórios)
4. Crie `[nome].agent.md` com persona, workflow e proibições
5. Atualize o roster no `principal.agent.md` e `copilot-instructions.md`

## Regras para Pull Requests

- Nunca abra PR com trabalho em andamento (WIP)
- Todo agente deve ter frontmatter YAML completo
- Todo agente deve ter seções: Persona, Protocolo de Escalamento, Fluxo de Trabalho, Nunca Faça
- Conteúdo em Português (pt-BR)
- Conventional Commits: `feat:`, `fix:`, `docs:`, `chore:`

## Ciclo de Vida

```text
.experimental/ → uso real em projetos → validação → .curated/
```

Nunca mova diretamente para `.curated/` sem validação em produção.

## Referências

- [docs/architecture.md](docs/architecture.md) — Princípios e delegation graph
- [docs/conventions.md](docs/conventions.md) — Padrões de nomenclatura e frontmatter
- [skills/.system/template/SKILL.md](skills/.system/template/SKILL.md) — Template de referência
