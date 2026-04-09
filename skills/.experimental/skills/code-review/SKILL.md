---
name: code-review
description: Use quando precisar revisar código de um PR, branch ou changeset. Fornece checklist estruturado, classificação de severidade e padrões de feedback construtivo.
license: MIT
---

# Code Review

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Revisar pull requests antes de merge
- Revisar changesets de um branch ou commit específico
- Avaliar qualidade de código após refatoração
- Fazer review de segurança básico (para auditoria profunda, usar `security-audit`)

## Passos

### 1. Entender o contexto da mudança

Antes de olhar o código:
- Qual é o **objetivo** da mudança? (issue, spec, ADR)
- Qual é o **impacto** esperado? (novo comportamento, correção, refatoração)
- Qual é o **escopo**? (quantos arquivos, quais módulos)

Nunca revisar código sem entender a intenção.

### 2. Leitura completa do diff

Percorrer **todo** o diff antes de comentar:
- O que foi adicionado, removido e modificado
- Efeitos colaterais em outras partes do sistema
- Mudanças de comportamento implícitas (renomeações, reordenações, defaults alterados)

### 3. Checklist de revisão

#### 🔴 Bloqueadores (devem ser resolvidos antes do merge)

- **Bugs lógicos** — condições invertidas, off-by-one, null reference, race conditions
- **Vulnerabilidades de segurança** — injection, XSS, secrets expostos, auth bypass
- **Testes faltando** para comportamentos críticos ou novos
- **Quebra de contrato** — API, interface ou schema alterados sem versionamento
- **Dados sensíveis** — secrets, PII, tokens no código ou em logs

#### 🟠 Issues importantes (devem ser discutidos)

- **Lógica complexa sem testes** — código com branches ou edge cases não cobertos
- **Padrões inconsistentes** — não segue as convenções do projeto
- **Performance óbvia** — N+1 queries, loops desnecessários, alocações em hot path
- **Error handling inadequado** — exceções engolidas, erros silenciosos, catch genérico
- **Nomenclatura confusa** — nomes que escondem a intenção real

#### 🟡 Sugestões (melhoria, não bloqueio)

- Duplicação que pode ser extraída
- Comentários desatualizados ou enganosos
- Oportunidades de simplificação
- Melhorias de legibilidade

### 4. Padrões de feedback

**Bom feedback é:**
- **Específico** — apontar arquivo e linha, não "o código está ruim"
- **Acionável** — sugerir o que fazer, não apenas apontar o problema
- **Contextualizado** — explicar o porquê, não apenas o quê
- **Proporcional** — bloqueador com urgência, sugestão com leveza

**Formato recomendado:**
```
🔴 `arquivo.ts:42` — [Bug] Condição invertida no if: `user.active` deveria ser `!user.active`.
   Sugestão: inverter a condição para evitar que usuários inativos acessem o recurso.

🟡 `utils.ts:15` — [Simplificação] Este bloco pode ser substituído por `array.filter(Boolean)`.
```

**Nunca fazer:**
- Comentar sobre estilo sem impacto funcional
- Dar feedback passivo-agressivo ou sarcástico
- Reescrever o código do autor sem justificativa técnica

### 5. Verificação de testes

- Há testes cobrindo os **novos comportamentos**?
- Os testes existentes continuam passando?
- Casos de borda estão cobertos? (null, vazio, limite, erro)
- Os testes testam **comportamento**, não implementação?

### 6. Veredicto

```markdown
## Review: [Nome do PR / Branch]

### 🔴 Bloqueadores
- `arquivo.ts:42` — [descrição] → [sugestão]

### 🟠 Issues
- `arquivo.ts:78` — [descrição] → [sugestão]

### 🟡 Sugestões
- `arquivo.ts:15` — [descrição] → [sugestão]

### ✅ Pontos Positivos
[O que está bem feito — reconhecer bom trabalho é parte do review]

### Veredicto
🔴 Bloqueado | 🟡 Aprovado com ressalvas | ✅ Aprovado
```

## Anti-Patterns de Review

- ❌ **Rubber stamp** — aprovar sem ler
- ❌ **Nit-picking** — bloquear por estilo ou preferência pessoal
- ❌ **Review seletivo** — só olhar o que entende, ignorar o resto
- ❌ **Scope creep** — pedir mudanças fora do escopo do PR
- ❌ **Delay indefinido** — segurar review sem feedback claro

## Checklist de validação

- [ ] Diff lido completamente antes de comentar
- [ ] Contexto da mudança compreendido (issue, spec ou ADR relacionado)
- [ ] Checklist de revisão aplicado (bloqueadores → issues importantes → melhorias)
- [ ] Todos os comentários 🔴 Bloqueadores resolvidos antes de aprovar
- [ ] Testes cobrem os novos comportamentos e casos de borda críticos
- [ ] Nenhum secret ou dado sensível exposto
- [ ] Performance: sem N+1 queries ou re-renders desnecessários introduzidos
- [ ] Feedback construtivo: cada comentário com justificativa e sugestão

## Exemplos

### Comentário de review bem estruturado

```markdown
🔴 **[Bloqueador] SQL Injection em potencial**

`arquivo: src/users/repository.ts:42`

A query está sendo construída por concatenação de string com input do usuário:
```typescript
// ❌ Vulnerável
const query = `SELECT * FROM users WHERE email = '${email}'`
```

**Recomendação:** usar query parametrizada:
```typescript
// ✅ Seguro
const user = await db.query('SELECT * FROM users WHERE email = $1', [email])
```

Referência: OWASP A03:2021 Injection
```

### Review de PR via CLI

```bash
# Ver diff do PR
gh pr diff 42

# Aprovar com comentário
gh pr review 42 --approve --body "LGTM! Implementação sólida. Apenas o comentário de logging inline para considerar."

# Solicitar mudanças
gh pr review 42 --request-changes --body "Favor resolver o bloqueador de SQL injection antes do merge."
```
