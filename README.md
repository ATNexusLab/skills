# ATNexusLab/skills — Repositório de Agentes

Repositório central de **agentes e skills** da organização ATNexusLab.  
Compatível com o ecossistema [skills.sh](https://skills.sh) — instale em qualquer projeto com um único comando:

```sh
npx skills add ATNexusLab/skills
# ou
bunx skills add ATNexusLab/skills
```

---

## O que é este repositório

Um **time de IA reutilizável** que você puxa para qualquer projeto. Cada agente é um especialista com persona, workflow preciso e restrições de ferramentas definidas. O objetivo é ter o mesmo time de alta qualidade em todos os projetos da organização.

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
│   ├── agents/                          ← custom agents ativos (.agent.md copiados daqui)
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
│   ├── agents/     ← 14 agentes em desenvolvimento (SKILL.md + .agent.md)
│   └── skills/     ← skills em desenvolvimento
└── .system/
    ├── template/           ← template de referência (spec completa)
    └── creating-agents/    ← meta-agente para criar novos agentes
```

Cada agente em `.experimental/agents/` contém dois arquivos:

| Arquivo | Propósito |
|---------|-----------|
| `SKILL.md` | Workflow detalhado — carregado automaticamente como skill |
| `NOME.agent.md` | Template de custom agent — copie para `.github/agents/` no seu projeto |

---

## O Time — 14 Agentes

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
cp skills/.experimental/agents/pr-reviewer/pr-reviewer.agent.md .github/agents/
```

### Configuração Global Pessoal

Para ter o time disponível em todos os seus projetos:

```sh
cp skills/.experimental/agents/*/SKILL.md ~/.copilot/skills/
cp skills/.experimental/agents/*/*.agent.md ~/.copilot/agents/
```

---

## Criar um Novo Agente

Use a skill `creating-agents` (disponível após install) ou siga o template em `skills/.system/template/SKILL.md`.

---

**Repositório:** ATNexusLab/skills | **Idioma:** pt-BR | **Status:** Experimental