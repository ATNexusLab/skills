---
name: testing-patterns
description: Use quando precisar definir estratégia de testes, escrever testes eficazes ou melhorar cobertura. Cobre unit, integration, E2E, mocking, fixtures e anti-patterns.
license: MIT
---

# Testing Patterns

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Definir estratégia de testes para um projeto ou feature
- Escrever testes unitários, de integração ou E2E
- Escolher entre mocks, stubs, fakes e spies
- Melhorar cobertura de testes existentes
- Identificar e corrigir testes frágeis ou ineficazes

## Pirâmide de Testes

```
        ╱ E2E ╲          ← Poucos, lentos, alto custo
       ╱────────╲
      ╱Integration╲      ← Moderados, validam fronteiras
     ╱──────────────╲
    ╱   Unit Tests    ╲   ← Muitos, rápidos, isolados
   ╱────────────────────╲
```

**Regra prática:**
- **Unit:** 70% — rápidos, isolados, testam lógica pura
- **Integration:** 20% — testam fronteiras (DB, API, filesystem)
- **E2E:** 10% — testam fluxos críticos de ponta a ponta

## Padrões de Teste

### Arrange-Act-Assert (AAA)

```
// Arrange — preparar o cenário
const user = createUser({ email: "test@example.com" });

// Act — executar a ação
const result = await loginUser(user.email, "password123");

// Assert — verificar o resultado
expect(result.token).toBeDefined();
expect(result.user.email).toBe("test@example.com");
```

### Given-When-Then (BDD)

```
// Given — contexto inicial
dado que existe um usuário ativo com email "test@example.com"

// When — ação executada
quando o usuário faz login com credenciais válidas

// Then — resultado esperado
então deve retornar um token JWT válido
e o status deve ser 200
```

### Naming Convention

Nome do teste deve descrever o **comportamento**, não a implementação:
- ✅ `"deve retornar 404 quando usuário não existe"`
- ✅ `"deve rejeitar email com formato inválido"`
- ❌ `"testa o método findById"`
- ❌ `"teste 1"`

## Test Doubles

| Tipo | Quando Usar | Exemplo |
|------|-------------|---------|
| **Mock** | Verificar que uma dependência foi chamada corretamente | Verificar que `emailService.send()` foi chamado |
| **Stub** | Forçar retorno específico de uma dependência | `userRepo.findById()` retorna user fake |
| **Fake** | Substituir implementação real por versão simplificada | In-memory database em vez de PostgreSQL |
| **Spy** | Observar chamadas sem alterar comportamento | Contar quantas vezes uma função foi chamada |

**Regra:** preferir **stubs** e **fakes** sobre mocks. Mocks testam implementação, não comportamento.

## Estratégias por Tipo

### Unit Tests
- Testar **uma unidade** de lógica por vez
- Isolar dependências com stubs/fakes
- Focar em: caminho feliz, erros esperados, valores de borda
- Devem rodar em milissegundos

### Integration Tests
- Testar **fronteiras**: banco de dados, APIs externas, filesystem
- Usar banco real (container) ou fake confiável
- Setup e teardown limpos entre testes
- Testar: queries, migrations, serialização, auth

### E2E Tests
- Testar **fluxos completos** do ponto de vista do usuário
- Poucos, focados nos fluxos mais críticos (login, compra, cadastro)
- Tolerantes a delays (usar waits explícitos, não sleeps)
- Rodar em ambiente o mais próximo possível de produção

## Fixtures e Factories

Preferir **factories** sobre fixtures estáticas:

```
// Factory — flexível, explícita
const user = buildUser({ role: "admin", active: true });

// Fixture estática — rígida, esconde contexto
const user = fixtures.adminUser; // quais campos tem? está ativo?
```

**Boas práticas:**
- Cada teste cria seus próprios dados — nunca depender de estado global
- Usar defaults sensatos na factory, sobrescrever apenas o relevante
- Limpar dados entre testes (truncate, rollback ou container efêmero)

## Checklist de Cobertura

Para cada feature, garantir testes para:
- [ ] Caminho feliz (happy path)
- [ ] Validação de input (inválido, vazio, nulo, formato errado)
- [ ] Valores de borda (zero, máximo, string vazia, lista vazia)
- [ ] Casos de erro (exceções, timeouts, indisponibilidade)
- [ ] Permissões (autorizado vs não autorizado)
- [ ] Idempotência (executar duas vezes produz o mesmo resultado?)

## Anti-Patterns de Testes

| Anti-Pattern | Problema | Solução |
|-------------|----------|---------|
| **Teste frágil** | Quebra com qualquer mudança de implementação | Testar comportamento, não implementação |
| **Teste lento** | Suite leva minutos para rodar | Isolar, paralelizar, usar fakes |
| **Teste que testa o mock** | Só verifica que o mock foi chamado | Testar o resultado, não a chamada |
| **Setup gigante** | 50 linhas de setup para 1 assertion | Extrair factory, simplificar cenário |
| **Assertion faltando** | Teste passa sem verificar nada | Sempre ter pelo menos 1 assertion explícita |
| **Teste interdependente** | Ordem de execução importa | Cada teste deve ser independente |
| **Cobertura sem valor** | 100% coverage, 0% confiança | Focar em comportamentos, não em linhas |

## Passos

### 1. Definir a estratégia de testes

Antes de escrever qualquer teste:
- Identificar o tipo de componente: função pura, módulo com dependências, componente UI, serviço HTTP
- Decidir o nível de teste adequado (unit, integration, E2E)
- Mapear as dependências externas que precisarão de doubles

### 2. Escrever o teste antes do código (TDD) ou mapear cobertura existente

Para TDD:
1. Escrever o teste que falha (Red)
2. Implementar o mínimo para passar (Green)
3. Refatorar sem quebrar (Refactor)

Para cobertura retroativa:
1. Identificar os caminhos críticos do código
2. Priorizar: happy path → error cases → edge cases

### 3. Implementar os testes

- Um conceito por teste — nomes descritivos no formato `deve_[comportamento]_quando_[contexto]`
- Usar o padrão AAA: Arrange, Act, Assert
- Isolar dependências externas com mocks/stubs quando necessário
- Nunca testar implementação, testar comportamento

### 4. Executar e validar

```bash
# Rodar todos os testes
npm test / pytest / go test ./...

# Rodar com cobertura
npm test -- --coverage / pytest --cov
```

### 5. Revisar a cobertura

- Verificar `## Checklist de Cobertura` abaixo
- Identificar casos de borda não cobertos
- Adicionar testes de regressão para bugs corrigidos

## Exemplos

### Teste unitário (JavaScript/Jest)

```javascript
// ✅ Bom: testa comportamento, não implementação
describe('formatCurrency', () => {
  it('deve formatar valor positivo em BRL', () => {
    expect(formatCurrency(1234.56, 'BRL')).toBe('R$ 1.234,56')
  })

  it('deve retornar "R$ 0,00" para valor zero', () => {
    expect(formatCurrency(0, 'BRL')).toBe('R$ 0,00')
  })

  it('deve lançar erro para valor negativo', () => {
    expect(() => formatCurrency(-1, 'BRL')).toThrow('Valor não pode ser negativo')
  })
})
```

### Teste de integração (Python/pytest)

```python
def test_criar_usuario_deve_salvar_no_banco_e_enviar_email(db_session, mock_email_service):
    # Arrange
    payload = {"email": "user@example.com", "nome": "Usuário Teste"}
    
    # Act
    response = client.post("/usuarios", json=payload)
    
    # Assert
    assert response.status_code == 201
    assert db_session.query(Usuario).filter_by(email=payload["email"]).first()
    mock_email_service.send_welcome.assert_called_once_with(payload["email"])
```
