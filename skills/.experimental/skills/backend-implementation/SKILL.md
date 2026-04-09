---
name: backend-implementation
description: Use quando precisar implementar APIs, serviços, jobs, integrações ou qualquer lógica de servidor. Fornece padrões de implementação, convenções e checklist de validação.
license: MIT
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
- Documentação de arquitetura do projeto — padrões arquiteturais em uso
- ADRs ou decisões registradas — decisões que afetam esta implementação
- Spec da feature (buscar em docs, issues ou tasks do projeto)

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

## Checklist de validação

- [ ] Contrato da spec seguido (tipos, campos, status codes)
- [ ] Validação de entrada na camada handler (não no service)
- [ ] Erros tipados e tratados em todas as camadas
- [ ] Sem secrets hardcoded — usar variáveis de ambiente
- [ ] Queries com índices adequados (sem N+1)
- [ ] Logs estruturados nos pontos críticos (entrada, saída, erros)
- [ ] Testes de integração cobrindo happy path e error cases principais
- [ ] Endpoints autenticados onde necessário
- [ ] Response envelope consistente com o padrão do projeto
- [ ] Lint e type-check passando

## Exemplos

### Handler com validação e error handling

```typescript
// handler.ts
export async function criarPedido(req: Request, res: Response) {
  // 1. Validar entrada
  const { error, value } = criarPedidoSchema.validate(req.body)
  if (error) {
    return res.status(400).json({
      error: { code: 'VALIDATION_ERROR', message: error.message }
    })
  }

  // 2. Delegar para o service
  const resultado = await pedidoService.criar(value, req.user.id)
  
  if (!resultado.ok) {
    return res.status(resultado.status).json({
      error: { code: resultado.code, message: resultado.message }
    })
  }

  return res.status(201).json({ data: resultado.data })
}
```

### Service com camadas separadas

```typescript
// service.ts
export async function criar(dados: CriarPedidoDTO, usuarioId: string) {
  const usuario = await usuarioRepository.findById(usuarioId)
  if (!usuario) {
    return { ok: false, status: 404, code: 'USER_NOT_FOUND', message: 'Usuário não encontrado' }
  }

  const pedido = await pedidoRepository.create({ ...dados, usuarioId })
  await emailService.enviarConfirmacao(usuario.email, pedido)
  
  logger.info({ pedidoId: pedido.id, usuarioId }, 'Pedido criado com sucesso')
  return { ok: true, data: pedido }
}
```
