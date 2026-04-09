# ATNexusLab/skills — Repositório de Agentes

Repositório central de **agentes e skills** da organização ATNexusLab.  
Compatível com o ecossistema [skills.sh](https://skills.sh) e o open standard [agentskills.io](https://agentskills.io) — instale em qualquer projeto com um único comando:

```sh
npx skills add ATNexusLab/skills
# ou
bunx skills add ATNexusLab/skills
```

---

## O que é este repositório

Um **sistema cognitivo reutilizável** — um time de 15 agentes de IA especializados (14 especialistas + 1 orquestrador) que você puxa para qualquer projeto. Cada agente tem persona, workflow preciso, delegação e restrições de ferramentas definidas.

> Agent = cérebro (decide o que fazer) · Skill = mão (define como executar) · Instructions = leis · Docs = memória · Tasks = estado

### Arquitetura de Duas Camadas

```
CAMADA 1 — Global Pessoal
~/.copilot/
├── copilot-instructions.md     ← regras pessoais cross-projeto
├── agents/                     ← custom agents pessoais (.agent.md)
└── skills/                     ← skills pessoais (SKILL.md)

CAMADA 2 — Projeto (via npx install)
projeto/
├── .github/
│   ├── copilot-instructions.md          ← orquestrador lean do projeto
│   ├── agents/                          ← custom agents ativos
│   └── skills/                          ← skills instaladas automaticamente
```

---

## Estrutura do Repositório

```
skills/
├── .curated/
│   ├── agents/     ← agentes estáveis, prontos para produção
│   └── skills/     ← skills estáveis, prontas para produção
├── .experimental/
│   ├── agents/     ← 15 agentes em desenvolvimento (.agent.md)
│   └── skills/     ← 10 skills em desenvolvimento (SKILL.md)
└── .system/
    ├── template/           ← template de referência (spec completa)
    └── creating-agents/    ← meta-agente para criar novos agentes

docs/
├── architecture.md         ← princípios, delegation graph, regras de design
├── conventions.md          ← nomenclatura, frontmatter, ciclo de vida
└── context/decisions/      ← ADRs (decisões arquiteturais)
```

Cada agente em `.experimental/agents/` é um arquivo `.agent.md` (persona + delegação). As skills correspondentes ficam em `.experimental/skills/` como `SKILL.md` (workflow detalhado).

---

## O Time — 15 Agentes (14 Especialistas + 1 Orquestrador)

### Orquestrador

| Agente | Quando Usar |
|--------|-------------|
| `principal` | Objetivo complexo que requer múltiplas especialidades |

### Time de Processo

| Agente | Quando Usar |
|--------|-------------|
| `specs-collector` | Levantar requisitos de uma feature ou projeto |
| `test-driven-developer` | Implementar com ciclo TDD completo (red → green → refactor) |
| `pr-reviewer` | Revisar pull requests (segurança, lógica, testes, estilo) |
| `github-operator` | Operações GitHub via CLI/API (issues, PRs, releases, workflows) |
| `security-analyst` | Auditar código, dependências e configurações por vulnerabilidades |
| `instructions-expert` | Criar ou atualizar instruções do Copilot CLI (todos os 5 tipos) |
| `performance-analyst` | Identificar gargalos com dados, fazer benchmarks e otimizar |

### Time de Engenharia

| Agente | Quando Usar |
|--------|-------------|
| `architect` | Tomar decisões técnicas, avaliar tradeoffs, criar ADRs |
| `backend` | Implementar APIs, serviços, jobs e integrações de servidor |
| `frontend` | Implementar componentes, páginas e interfaces web |
| `ui-ux-specialist` | Criar specs de UX, fluxos de usuário e critérios de acessibilidade |
| `mobile-expert` | Implementar features mobile (React Native, Flutter, Swift, Kotlin) |
| `sql-dba` | Schemas SQL, migrations, queries complexas e índices |
| `nosql-dba` | Modelagem NoSQL orientada a padrões de acesso |

---

## Como Usar

### Instalar no Projeto

```sh
npx skills add ATNexusLab/skills
```

Isso copia os `SKILL.md` para `.github/skills/` do projeto. As skills são carregadas automaticamente pelo Copilot CLI quando relevantes.

### Ativar um Agente como Custom Agent

Para que um agente tenha contexto próprio (delegação real multi-agent), copie o `.agent.md` para o seu projeto:

```sh
cp skills/.experimental/agents/pr-reviewer.agent.md .github/agents/
```

### Configuração Global Pessoal

Para ter o time disponível em todos os seus projetos:

```sh
cp skills/.experimental/agents/*.agent.md ~/.copilot/agents/
cp skills/.experimental/skills/*/SKILL.md ~/.copilot/skills/
```

---

## Documentação

| Documento | Conteúdo |
|-----------|----------|
| [docs/architecture.md](docs/architecture.md) | Princípios, delegation graph, regras de design, anti-patterns |
| [docs/conventions.md](docs/conventions.md) | Nomenclatura, frontmatter obrigatório, ciclo de vida |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Como contribuir, criar agentes, regras de PR |

---

## Criar um Novo Agente

Use a skill `creating-agents` (disponível após install) ou siga o template em `skills/.system/template/SKILL.md`.

Leia o [CONTRIBUTING.md](CONTRIBUTING.md) para regras e processo.

---

**Repositório:** ATNexusLab/skills | **Idioma:** pt-BR | **Status:** Experimental | **Standard:** [agentskills.io](https://agentskills.io)