---
name: database-design
description: Use quando precisar modelar dados, criar schemas, migrations, queries complexas ou otimizar acesso a bancos SQL e NoSQL.
---

# Database Design

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Modelar um schema de banco de dados novo
- Criar ou revisar migrations
- Escrever ou otimizar queries complexas
- Escolher entre SQL e NoSQL para um caso de uso
- Projetar padrões de acesso para NoSQL

## SQL — Padrões e Boas Práticas

### Modelagem

- Normalizar até 3NF por padrão; desnormalizar apenas quando performance exigir
- Chaves primárias: UUIDs para sistemas distribuídos, BIGINT autoincrement para sistemas internos
- Chaves estrangeiras com `ON DELETE` explícito (não usar CASCADE sem analisar impacto)
- Timestamps `created_at` e `updated_at` em todas as tabelas

### Migrations

- Uma migration por mudança atômica
- Migrations devem ser reversíveis (up + down)
- Nunca alterar dados em migration de schema (usar migration de dados separada)
- Migrations em produção: testar em staging primeiro, executar em horário de baixo tráfego

### Índices

- Index em todas as colunas usadas em `WHERE`, `JOIN` e `ORDER BY` frequentes
- Índices compostos: ordem importa (coluna mais seletiva primeiro)
- Verificar índices não utilizados com `pg_stat_user_indexes` (PostgreSQL)
- Índices têm custo de escrita — não indexar tudo

### Queries

```sql
-- Usar EXPLAIN ANALYZE para entender o plano de query
EXPLAIN ANALYZE SELECT ...;

-- Evitar SELECT * em produção
SELECT id, nome, email FROM usuarios WHERE ativo = true;

-- Paginação eficiente com cursor (evitar OFFSET em tabelas grandes)
SELECT * FROM pedidos WHERE id > :cursor ORDER BY id LIMIT 20;
```

## NoSQL — Padrões e Boas Práticas

### Escolha do banco

| Banco | Quando usar |
|-------|------------|
| MongoDB | Documentos com schema flexível, queries ad-hoc |
| Redis | Cache, sessões, pub/sub, rate limiting |
| DynamoDB | Alta escala, padrões de acesso previsíveis |
| Firestore | Apps mobile/web com sync em tempo real |

### Modelagem NoSQL

**Diferente do SQL: modelar pelos padrões de acesso, não pela normalização.**

- Definir os padrões de acesso primeiro: "quais queries o sistema faz?"
- Desnormalização é esperada — duplicar dados para evitar joins
- Documentos grandes vs. muitos documentos pequenos: depende do caso

### MongoDB
```javascript
// Indexar campos de busca frequente
db.usuarios.createIndex({ email: 1 }, { unique: true });
db.pedidos.createIndex({ usuario_id: 1, criado_em: -1 });

// Projeção: retornar apenas o necessário
db.usuarios.find({ ativo: true }, { nome: 1, email: 1 });
```

### Redis
```
# Cache com TTL
SET user:123 "{...}" EX 3600

# Rate limiting
INCR rate:user:123
EXPIRE rate:user:123 60
```

## Checklist de Revisão de Schema

- [ ] Chaves primárias definidas
- [ ] Chaves estrangeiras com constraint explícita
- [ ] Índices nos campos de busca principais
- [ ] Timestamps de auditoria (`created_at`, `updated_at`)
- [ ] Migration reversível com down
- [ ] Sem alteração de dados em migration de schema
- [ ] Testado com dados de volume realista
