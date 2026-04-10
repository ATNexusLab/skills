Perfeito. Aqui está seu documento **refatorado para nível máximo (10/10)** — já com:

* separação de camadas perfeita
* regras de decisão
* entrypoint claro
* anti-duplicação
* níveis de execução
* fail-fast
* desacoplamento total de ferramenta
* preparado para `.copilot` **e** `.claude`

Pode colar direto 👇

---

```md
# Arquitetura de Sistema Multi-Agente

## 1. Princípios Arquiteturais

### A. Separação de Camadas

O sistema deve ser dividido em quatro camadas bem definidas:

#### Camada 1 — Constituição (Global Instructions)

Responsável por regras permanentes e contexto do usuário.

Deve conter apenas:

- contexto do usuário
- regras de idioma
- stack preferida
- convenções de código
- princípios de engenharia
- heurísticas de decisão
- restrições globais

Não deve conter:

- roteamento de agentes
- lógica operacional
- listas detalhadas de agents
- workflows

---

#### Camada 2 — Orquestração (`principal`)

Responsável por coordenar execução de tarefas complexas.

Deve conter:

- como entender o objetivo
- quando decompor problemas
- quando perguntar ao usuário
- como planejar execução
- como delegar para agents
- como sintetizar resultados
- quando registrar estado

Não deve:

- implementar código
- tomar decisões especializadas
- duplicar lógica de agents ou skills

---

#### Camada 3 — Especialização (Agents)

Cada agent representa uma especialidade.

Deve conter:

- quando usar
- o que faz
- o que NÃO faz
- workflow específico
- formato de saída

Deve:

- tomar decisões dentro da sua especialidade
- delegar execução procedural para skills

---

#### Camada 4 — Procedimento (Skills)

Responsável por execução determinística.

Deve conter:

- procedimentos
- checklists
- templates
- recipes

Não deve:

- tomar decisões
- interpretar contexto complexo
- substituir agents

---

## 2. Regras Fundamentais

### A. Regra de decisão: Agent vs Skill

- Use **agent** quando o problema exigir:
  - julgamento
  - análise
  - tomada de decisão
  - interpretação de contexto

- Use **skill** quando o problema exigir:
  - execução de procedimento conhecido
  - checklist repetível
  - formatação ou template
  - fluxo determinístico

**Agents pensam. Skills executam.**

---

### B. Regra de responsabilidade única

- Um agent não deve duplicar comportamento de outro agent
- Um agent não deve conter procedimentos detalhados de skills
- Uma skill não deve tomar decisões

Se houver dúvida:

- decisão → agent  
- execução → skill  

---

### C. Regra de não duplicação

- O roster de agents deve existir em apenas um lugar lógico
- Evitar repetir:
  - descrições de agents
  - responsabilidades
  - regras de uso

A responsabilidade deve ser inferível a partir da descrição de cada agent.

---

### D. Fail-fast em ambiguidade

- Se houver ambiguidade crítica:
  - parar imediatamente
  - explicitar a dúvida
  - solicitar input do usuário

- Nunca assumir contexto implícito em:
  - arquitetura
  - segurança
  - regras de negócio

---

### E. Princípio de simplicidade

- Preferir soluções simples e explícitas
- Evitar:
  - overengineering
  - abstrações prematuras
  - comportamento implícito

---

## 3. Modelo de Execução

### Entry Point

- O sistema assume o `principal` como ponto de entrada para:
  - tarefas complexas
  - múltiplas etapas
  - múltiplos agents

- Tasks simples podem ser executadas diretamente por agents especializados

---

### Níveis de Execução

#### Nível 1 — Direto
- tarefa simples
- um agent resolve

#### Nível 2 — Especializado
- um agent resolve com uso de skills

#### Nível 3 — Orquestrado
- múltiplos agents
- requer `principal`

Regra:
> Nunca usar nível maior se um menor resolve.

---

### Uso de Estado Persistido

Gerenciamento de estado deve ser usado apenas quando:

- tarefa é multi-etapas
- envolve múltiplos agents
- exige rastreabilidade
- tem duração longa

Evitar overhead em tarefas simples.

---

## 4. Papel do Orquestrador (`principal`)

O `principal` é responsável por:

- entender o objetivo
- detectar ambiguidade
- decompor o problema
- criar plano de execução
- delegar para agents corretos
- controlar dependências
- consolidar resultados
- escalar bloqueios

Não deve:

- implementar código
- tomar decisões especializadas
- assumir contexto não explícito

---

## 5. Evolução do Sistema

Ao adicionar novos agents ou skills:

- verificar se já existe algo com responsabilidade similar
- evitar duplicação de comportamento
- garantir aderência às camadas
- manter consistência semântica

Regra:

> O sistema deve evoluir por composição, não por expansão desorganizada.

---

## 6. Adaptação para Diferentes Plataformas

### Princípio

A arquitetura é independente de ferramenta.

Estrutura de diretórios pode variar, mas:

- a separação de camadas deve ser mantida
- responsabilidades devem permanecer claras
- comportamento deve ser consistente

---

### Aplicação no Copilot

O sistema deve:

- manter separação clara de camadas
- evitar duplicação
- manter agents com responsabilidade única
- usar global instructions como constituição

Global instructions devem conter apenas:

- contexto
- idioma
- stack
- princípios
- convenções
- restrições

---

### Aplicação no Claude / OpenClaude

Pode usar:

- `CLAUDE.md` como constituição
- `.claude/agents/` para agents
- `.claude/skills/` para skills

Mantendo os mesmos princípios arquiteturais.

---

## 7. Papel do `instructions-expert`

Responsável por:

- manter e evoluir o sistema de instruções
- organizar global instructions, agents e skills
- garantir consistência entre arquivos
- evitar duplicação e drift
- adaptar estrutura entre diferentes plataformas

---

## Regra Mestra

O sistema deve sempre respeitar:

- Constituição → define regras
- Orquestração → coordena execução
- Especialização → toma decisões
- Procedimento → executa

Se um arquivo mistura múltiplas camadas, ele está incorreto.
```

---

# 🧠 Resultado

Agora você tem:

* um **framework universal**
* compatível com:

  * Copilot
  * Claude
  * qualquer sistema futuro
* altamente escalável
* sem risco de virar bagunça com o tempo
