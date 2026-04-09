---
name: project-setup
description: Use quando iniciar um projeto novo e precisar configurar a base de instruções, agentes e skills específicos para aquele contexto. Guia o discovery completo e a criação da camada de configuração do projeto.
license: MIT
---

<required>
*CRÍTICO* Adicione os seguintes passos à sua lista de Todos antes de começar:
1. Verificar se `.github/copilot-instructions.md` já existe no projeto
2. Conduzir discovery: coletar contexto do projeto (nome, propósito, stack, padrões, workflow)
3. Mapear quais agents/skills globais são relevantes para este projeto
4. Gerar `.github/copilot-instructions.md` específico do projeto
5. Identificar se o projeto precisa de agents ou skills customizados além da base global
6. Reportar ao `principal` o resumo do que foi configurado
</required>

# Project Setup

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Ao iniciar um projeto novo que vai usar o ecosistema ATNexusLab/skills
- Ao integrar o Copilot CLI em um projeto existente sem configuração
- Ao revisar e atualizar a configuração de um projeto já em andamento

## Passo 1 — Verificar Estado Atual

Verificar se `.github/copilot-instructions.md` já existe:
- **Se não existir**: seguir o fluxo de criação do zero (passos 2-6).
- **Se existir**: ler o conteúdo, entender o que já está configurado e ir direto para o Passo 5 (apenas atualizar o que está desatualizado).

## Passo 2 — Discovery do Projeto

Fazer as seguintes perguntas ao usuário (não assumir nenhuma resposta):

### Contexto Geral
- Qual é o nome e propósito do projeto?
- Qual é o domínio de negócio? (ex: fintech, saúde, e-commerce, SaaS B2B)
- Qual é o tamanho esperado do projeto? (MVP, produto em crescimento, sistema legado)

### Stack Técnica
- Qual é a linguagem principal? (ex: TypeScript, Python, Go, Java)
- Qual é o framework principal? (ex: Next.js, FastAPI, Spring Boot)
- Qual é o banco de dados? (SQL/NoSQL, qual engine)
- Há infraestrutura relevante? (Docker, Kubernetes, AWS, GCP)

### Convenções do Projeto
- Há guia de estilo de código já definido?
- Qual é a estratégia de testes? (TDD, coverage mínimo, frameworks)
- Qual é o fluxo de Git? (trunk-based, gitflow, feature branches)
- Há padrões de commit? (Conventional Commits, etc.)

### Workflow do Time
- Quais agentes do time global serão mais usados neste projeto?
- Há algum papel ou responsabilidade específica do projeto que não existe nos agentes globais?
- Qual é o idioma de resposta preferido?

## Passo 3 — Mapear Agents e Skills Relevantes

Com base no discovery, identificar quais agentes do time global são relevantes:

| Se o projeto tem... | Agentes prioritários |
|---------------------|---------------------|
| API REST/gRPC | `backend`, `api-design`, `specs-collector` |
| Frontend web | `frontend`, `ui-ux-specialist` |
| Mobile | `mobile-expert` |
| Banco SQL | `sql-dba` |
| Banco NoSQL | `nosql-dba` |
| CI/CD / infra | `devops` |
| Segurança crítica | `security-analyst` |
| Documentação técnica | `documentation-writer` |
| PRs regulares | `pr-reviewer` |

## Passo 4 — Gerar `.github/copilot-instructions.md`

Criar o arquivo com a seguinte estrutura, preenchendo com os dados do discovery:

```markdown
# Copilot Instructions — [Nome do Projeto]

## Contexto

[Descrição do projeto, propósito, domínio de negócio.]

**Stack:** [Linguagem, framework, banco, infra]
**Idioma de resposta:** [pt-BR ou en-US]

---

## Stack e Tecnologias

- **Linguagem principal:** [ex: TypeScript 5.x]
- **Framework:** [ex: Next.js 15 — App Router]
- **Banco de dados:** [ex: PostgreSQL 16 via Prisma]
- **Infraestrutura:** [ex: Docker + AWS ECS]

---

## Convenções de Código

[Listar as convenções específicas do projeto: guia de estilo, naming, estrutura de pastas]

---

## Regras de Negócio Globais

[Regras críticas de negócio que todos os agentes devem conhecer e respeitar]

---

## Workflow do Time

- **Branches:** [estratégia]
- **Commits:** [padrão]
- **PRs:** [processo de review]
- **Testes:** [estratégia e cobertura mínima]

---

## Agents Prioritários para Este Projeto

[Listar apenas os agents relevantes para este projeto específico]

---

## Referências

| Arquivo | Propósito |
|---------|-----------|
| [caminhos relevantes do projeto] | [propósito] |
```

## Passo 5 — Identificar Necessidades Específicas

Verificar se o projeto tem necessidades que NÃO são cobertas pelos agents/skills globais:
- Há um domínio de negócio muito específico que exige um agent customizado?
- Há ferramentas ou frameworks proprietários que precisam de instruções especiais?

Se sim: reportar ao `principal` a necessidade, que irá acionar `instructions-expert` para criar os arquivos específicos.

## Passo 6 — Reportar ao `principal`

Entregar ao `principal`:
- Checklist do que foi criado/atualizado
- Path de cada arquivo gerado
- Agents e skills mapeados como relevantes para o projeto
- Necessidades identificadas que ainda precisam de configuração adicional

## Referências

- `skills/.system/template/SKILL.md` — template para criar novos agents/skills
- `skills/.system/creating-agents/SKILL.md` — guia completo de criação de agents
- `.github/copilot-instructions.md` deste repositório — exemplo de instruções globais
