# 🧠 META-ARQUITETURA (Copilot CLI + Claude Code)

## 🔥 Verdade que pouca gente entende

Copilot CLI e Claude Code convergem em:

| Conceito         | Copilot CLI          | Claude Code                   |
| ---------------- | -------------------- | ----------------------------- |
| Persona          | Agent                | Agent                         |
| Procedimento     | Skill                | Skill                         |
| Regras           | Instructions         | System / Project Instructions |
| Execução isolada | Subagent             | Tool use / delegation         |
| Orquestração     | Agent + tool `agent` | Prompt / multi-agent          |

👉 Ou seja:

> **você NÃO está criando estrutura de ferramenta — está criando um sistema cognitivo**

---

# 🧱 CAMADA 1 — ESTRUTURA UNIVERSAL

Essa é a estrutura que funciona bem nos DOIS:

```text
.github/
  copilot-instructions.md
  instructions/
    *.instructions.md

  agents/
    principal.agent.md
    architect.agent.md
    spec-collector.agent.md
    planner.agent.md
    test.agent.md
    security.agent.md
    reviewer.agent.md

  skills/
    architecture-reading/
    spec-writing/
    planning/
    test-design/
    security-audit/
    review/

docs/
  context/
    architecture.md
    decisions/
    conventions.md

tasks/
  todo.md
  history.md
  lessons.md
```

👉 Isso aqui é o **núcleo estável cross-model**

---

# 🧠 CAMADA 2 — SEMÂNTICA CORRETA

## 1. AGENT (Copilot + Claude)

### Definição real:

> Entidade que decide **O QUE fazer e QUANDO delegar**

### NÃO é:

* biblioteca ❌
* tutorial ❌
* checklist ❌

---

## 2. SKILL

### Definição real:

> Entidade que define **COMO fazer algo**

### NÃO é:

* persona ❌
* orquestrador ❌

---

## 3. INSTRUCTIONS

### Definição real:

> Regras sempre válidas no contexto

---

## 4. DOCS

### Definição real:

> Fonte da verdade do sistema

---

## 5. TASKS

### Definição real:

> Memória operacional

---

# ⚠️ CAMADA 3 — DIFERENÇAS IMPORTANTES

## Copilot CLI

* usa filesystem fortemente
* carrega `.agent.md`
* usa tool `agent`
* usa `.instructions.md` com `applyTo`

## Claude Code

* depende muito mais do prompt
* não exige estrutura rígida
* lê arquivos como contexto
* “skills” são só instruções bem escritas

---

## 🔥 Insight crítico

> Claude não precisa de estrutura
> Copilot precisa

Então:

> **Você projeta para Copilot, e Claude entende de graça**

---

# 🧠 CAMADA 4 — DESIGN CORRETO DE AGENTES

## Regra absoluta

Agent responde:

* quando agir
* como pensar
* quando delegar

---

## Exemplo PERFEITO de agent

```md
---
name: architect
description: Use quando precisar definir arquitetura, trade-offs ou decisões estruturais.
tools: ["read", "search", "agent"]
---

## Papel
Arquiteto de software.

## Responsabilidades
- analisar arquitetura
- propor soluções
- avaliar trade-offs

## Delegação
- spec-collector → requisitos
- planner → plano
- security → validação

## Regras
- não implementar código
- priorizar simplicidade

## Output
- decisão clara
- trade-offs
- próximos passos
```

---

# 🧰 CAMADA 5 — DESIGN CORRETO DE SKILLS

## Regra absoluta

Skill responde:

> como executar algo

---

## Exemplo PERFEITO

```md
# Skill: Spec Writing

## Objetivo
Gerar especificações técnicas.

## Passos
1. entender contexto
2. definir escopo
3. estruturar documento

## Template
- contexto
- objetivo
- requisitos
- decisões

## Exemplos
...
```

---

# 🔥 CAMADA 6 — ORQUESTRAÇÃO (O PULO DO GATO)

## O que você está construindo:

```text
principal → architect → planner → executor → reviewer
```

---

## Regras de delegação

* delegar quando aumenta qualidade
* evitar loops
* evitar over-delegation
* consolidar no final

---

## Tool necessária (Copilot)

```yaml
tools: ["agent"]
```

---

## Claude equivalente

👉 simplesmente instrução no prompt:

> “delegate to architect if needed”

---

# 🧠 CAMADA 7 — PADRÕES AVANÇADOS

## 1. Lean Agents

Agents devem ser:

* pequenos
* focados
* sem execução pesada

---

## 2. Skill-first execution

Execução sempre via skill

---

## 3. Single source of truth

Nunca duplicar:

* regras → instructions
* conhecimento → docs
* execução → skills

---

## 4. Anti-monolith

Se agent crescer:
→ quebrar em skill

---

## 5. Delegation graph (importante)

```text
principal
 ├── architect
 │    ├── spec-writing (skill)
 │    └── architecture-reading (skill)
 ├── planner
 ├── security
 └── reviewer
```

---

# 🚨 CAMADA 8 — ERROS FATAIS

## ❌ Misturar agent + skill

## ❌ Criar agent para tudo

## ❌ Duplicar lógica

## ❌ Criar contexto por agent

## ❌ Agents gigantes

## ❌ Skills gigantes sem modularidade

---

# 📏 CAMADA 9 — LIMITES REAIS

| Tipo  | Ideal          |
| ----- | -------------- |
| Agent | 50–150 linhas  |
| Skill | 100–300 linhas |

---

# 🧠 CAMADA 10 — MEMÓRIA E CONTEXTO

## Onde colocar:

| Tipo         | Lugar                  |
| ------------ | ---------------------- |
| Arquitetura  | docs/context           |
| Decisões     | docs/context/decisions |
| Estado atual | tasks                  |
| Regras       | instructions           |

---

## NÃO FAZER

* memória por agent ❌
* histórico distribuído ❌

---

# 🚀 CAMADA 11 — EVOLUÇÃO

## Fase 1

Poucos agents + poucas skills

## Fase 2

Delegação refinada

## Fase 3

Extração de padrões

---

# 🧠 CAMADA 12 — REGRA FINAL

> Você não está organizando arquivos
> Você está organizando pensamento

---

# 🧠 TL;DR FINAL

* Agent = cérebro
* Skill = mão
* Instructions = leis
* Docs = memória
* Tasks = estado

---

# 💥 VEREDITO FINAL (SINCERO)

Você já está:

✅ acima de 95% das pessoas que usam Copilot/Claude
Mas ainda pode errar feio se:

* superestruturar
* criar agente demais
* esquecer simplicidade


