---
name: backend-implementation
description: Use quando precisar implementar APIs, serviços, jobs, integrações ou qualquer lógica de servidor. Fornece padrões de implementação, convenções e checklist de validação.
---

# Backend Implementation

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Implementar endpoints de API (REST, GraphQL, gRPC)
- Criar serviços, jobs ou workers em background
- Integrar com sistemas externos (webhooks, mensageria, third-party APIs)
- Refatorar lógica de servidor existente

## Passos

### 1. Ler a spec e o ADR relevante

Antes de escrever qualquer código:
- `docs/context/architecture.md` — padrões arquiteturais em uso
- `docs/context/decisions/` — decisões que afetam esta implementação
- Spec da feature em `docs/` ou `tasks/`

Se não houver spec: **parar e chamar `specs-collector`**.

### 2. Mapear o contrato de interface

Definir claramente antes de implementar:
- **Endpoint/método:** path, verbo HTTP, parâmetros
- **Request:** schema de input, validações
- **Response:** schema de output, status codes
- **Erros:** quais erros podem ocorrer, como são reportados
- **Autenticação:** quem pode acessar

### 3. Implementar de fora para dentro

Ordem recomendada:
1. **Contrato** (interfaces, types, schemas)
2. **Handler/Controller** (recebe request, valida, delega)
3. **Service/Use Case** (lógica de negócio)
4. **Repository/Adapter** (acesso a dados ou serviços externos)

### 4. Tratamento de erro consistente

- Nunca deixar exceção sem tratamento explícito
- Distinguir erros de cliente (4xx) de erros de servidor (5xx)
- Nunca expor stack traces ou mensagens internas para o cliente
- Logar erros com contexto suficiente para debugging

### 5. Validação e segurança obrigatória

- Validar **todo** input externo antes de usar
- Sanitizar dados antes de persistir
- Nunca confiar em dados do cliente para autorização
- Usar prepared statements ou ORM para queries (sem SQL concatenado)

### 6. Checklist pré-entrega

- [ ] Contrato documentado ou atualizado
- [ ] Testes cobrindo: caminho feliz, erros esperados, casos de borda
- [ ] Build e lint passando
- [ ] Sem secrets hardcoded
- [ ] Sem dados sensíveis em logs
- [ ] Documentação de endpoint atualizada (se pública)

## Padrões Comuns

### Estrutura de resposta de erro
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Campo 'email' é obrigatório",
    "details": [...]
  }
}
```

### Retries e idempotência
- Operações de escrita devem ser idempotentes quando possível
- Implementar retry com backoff exponencial para chamadas externas
- Usar IDs de idempotência para operações críticas

### Paginação
- Preferir cursor-based pagination para grandes conjuntos
- Limite máximo de itens por página com default sensato
