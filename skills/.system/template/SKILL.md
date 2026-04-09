---
name: template
description: Template interno de referência para criar novos agentes e skills. Use ao criar um SKILL.md do zero.
metadata:
  internal: true
---

# Template de Agente/Skill

> ⚠️ Esta é uma referência interna. Copie esta estrutura para criar novos agentes ou skills.

---

## Campos do Frontmatter

| Campo | Obrigatório | Descrição |
|-------|-------------|-----------|
| `name` | ✅ | Identificador único — `kebab-case`, sem prefixos como `agent-` ou `skill-` |
| `description` | ✅ | **Critério de ativação automática**: responde à pergunta "quando devo carregar este arquivo?" |
| `type` | ❌ | `agent` para agentes com persona e fluxo completo; `skill` para habilidades específicas |
| `targets` | ❌ | Ferramentas-alvo: `copilot-cli`, `gemini-cli`, `antigravity` |
| `allowed-tools` | ❌ | Pré-aprova ferramentas. Use `shell` APENAS se scripts forem revisados e confiáveis |

---

## Estrutura de um Agente (SKILL.md completo)

```markdown
---
name: nome-do-agente
description: Use quando [gatilho preciso]. [Uma frase do que faz e entrega].
---

<required>
*CRÍTICO* Adicione os seguintes passos à sua lista de Todos antes de começar:
1. [Primeiro passo concreto]
2. [Segundo passo, com comando inline se necessário]
   ```bash
   comando-exemplo --flag valor
   ```
3. [Continue numerando até cobrir todo o fluxo]
</required>

# Nome do Agente

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Persona

[Quem é este agente. Papel, mentalidade, expectativas de qualidade inegociáveis.
Ex: "Sou o revisor de segurança. Não aprovo nenhum PR sem verificar os 10 pontos do checklist OWASP."]

## Protocolo de Escalonamento

Quando bloqueado ou em dúvida:
1. **Pare imediatamente** — não tome decisões arbitrárias.
2. Declare: "Bloqueado em [X]. Contexto: [Y]. Opções consideradas: [Z]."
3. Aguarde instrução do orquestrador ou do usuário.

## Fluxo de Trabalho

1. **[Nome do passo]** — O que fazer e como validar antes de avançar.
   ```bash
   # Exemplo de comando inline quando aplicável
   ```
2. **[Nome do passo]** — Continue numerando.
3. ...

## Ferramentas

Lista explícita das ferramentas necessárias:

- **[Ferramenta]**: para que serve neste agente.
- Se uma ferramenta precisa ser chamada mais de uma vez, escreva um script ao invés de chamá-la manualmente.

## Nunca Faça

- Nunca [proibição específica deste agente].
- Nunca [outra proibição].
```

---

## Estrutura de uma Skill (SKILL.md simples)

```markdown
---
name: nome-da-skill
description: Use quando [gatilho]. [Uma frase do que ensina ou habilita].
---

# Nome da Skill

## Quando Usar
[Descreva os cenários de ativação com exemplos concretos.]

## Passos
1. [Passo acionável]
2. [Passo acionável]

## Referências
[Links, exemplos, ou arquivos auxiliares na mesma pasta.]
```

---

## Estrutura do Custom Agent (.agent.md)

Crie este arquivo em `.github/agents/NOME.agent.md` (projeto) ou `~/.copilot/agents/NOME.agent.md` (global).

```markdown
---
name: nome-do-agente
description: Especialista em [área]. Use quando [gatilho preciso].
tools: ["read", "search", "edit", "execute"]
user-invocable: true
---

# [Nome do Agente]

[Persona e instruções gerais. Pode ser curto — os detalhes vivem na skill correspondente.]

Use a skill `/nome-do-agente` para o fluxo de trabalho detalhado.
```

### Aliases de Tools disponíveis

| Alias | O que faz |
|-------|-----------|
| `read` | Lê arquivos |
| `edit` | Edita arquivos |
| `search` | Busca em arquivos |
| `execute` / `shell` | Executa comandos shell |
| `agent` | Invoca outro custom agent |
| `web` | Busca e fetch de URLs |
| `todo` | Cria e gerencia listas de todos |

---

## Boas Práticas

- A `description` é o critério de ativação — escreva como "Use quando [situação]".
- O bloco `<required>` é o mais importante: força a IA a montar um plano antes de agir.
- Inclua código inline nos passos — torna o fluxo executável, não apenas descritivo.
- Scripts auxiliares ficam na mesma pasta que o `SKILL.md` e são automaticamente disponibilizados.
- Todo agente começa em `.experimental/` — promova para `.curated/` após validação em produção.
