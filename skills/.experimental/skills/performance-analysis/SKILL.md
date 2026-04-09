---
name: performance-analysis
description: Use quando precisar identificar gargalos de performance, fazer profiling, benchmarks ou otimizações em backend, frontend ou banco de dados.
license: MIT
---

# Performance Analysis

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Sistema está lento e a causa não é clara
- Antes de otimizar (para identificar o gargalo real)
- Definir SLOs de performance para um sistema
- Validar que uma otimização realmente melhorou os números

## Regra de Ouro

**Nunca otimize sem medir primeiro.** Intuição sobre onde está o gargalo está errada na maioria das vezes.

Ciclo: Medir → Identificar gargalo → Hipótese → Otimizar → Medir novamente.

## Métricas por Camada

### Backend / API
- **Latência p50, p95, p99** (não só média — outliers importam)
- **Throughput** (requests/s que o sistema aguenta)
- **Taxa de erro** (% de requests com falha)
- **Tempo de CPU e memória** sob carga

### Banco de Dados
- **Queries lentas** (slow query log)
- **N+1 queries** (query count por request)
- **Taxa de hit de índice** vs. sequential scans
- **Connection pool** utilization

### Frontend
- **Core Web Vitals:** LCP, FID/INP, CLS
- **Time to Interactive (TTI)**
- **Bundle size**
- **Network waterfall** (requests bloqueantes)

## Ferramentas por Stack

### Backend
```bash
# Node.js — profiling com clinic.js
clinic doctor -- node server.js
clinic flame -- node server.js

# Python — profiling
python -m cProfile -o output.prof app.py
python -m pstats output.prof

# Go — pprof
go tool pprof http://localhost:6060/debug/pprof/profile
```

### Banco de Dados
```sql
-- PostgreSQL: queries lentas
SELECT query, mean_exec_time, calls
FROM pg_stat_statements
ORDER BY mean_exec_time DESC LIMIT 20;

-- EXPLAIN ANALYZE
EXPLAIN (ANALYZE, BUFFERS) SELECT ...;
```

### Frontend
```
# Lighthouse (Chrome DevTools ou CLI)
npx lighthouse https://exemplo.com --view

# Bundle analyzer (webpack)
npx webpack-bundle-analyzer stats.json
```

## Checklist de Análise

### 1. Estabelecer baseline
- [ ] Medir latência p50/p95/p99 atual
- [ ] Medir throughput máximo atual
- [ ] Identificar os endpoints/paths mais lentos

### 2. Identificar gargalo
- [ ] CPU-bound? (alto CPU, baixa latência de I/O)
- [ ] I/O-bound? (alto wait time, baixo CPU)
- [ ] Memory? (GC pressure, OOM)
- [ ] Database? (slow queries, N+1, missing index)
- [ ] Network? (payloads grandes, muitos requests)

### 3. Hipótese e otimização
- [ ] Uma mudança por vez
- [ ] Medir o impacto de cada mudança isoladamente

### 4. Validar e documentar
- [ ] Comparar métricas antes e depois
- [ ] Documentar a otimização e o ganho obtido
- [ ] Verificar que não houve regressão em outros pontos

## Sinais de Alerta Comuns

- Query sem índice em tabela grande = sequential scan
- N+1 queries = query dentro de loop
- Bundle JS > 1MB = muito a carregar antes de renderizar
- Memory leak = uso de memória cresce continuamente
- CPU spike sem carga = GC ou computação síncrona na thread principal

## Passos

### 1. Definir a hipótese de problema

Antes de perfilar:
- Qual comportamento está lento? (endpoint, query, render, build)
- Qual é a métrica atual e qual a meta?
- Em qual ambiente ocorre? (prod, staging, local com dados reais?)

### 2. Medir antes de otimizar

**Nunca otimizar sem medir primeiro.**

```bash
# Backend — tempo de resposta de um endpoint
curl -w "@curl-format.txt" -s http://localhost:3000/api/endpoint

# Banco de dados — EXPLAIN ANALYZE
EXPLAIN ANALYZE SELECT * FROM usuarios WHERE email = 'user@example.com';

# Frontend — Lighthouse
npx lighthouse https://meusite.com --output json
```

### 3. Identificar o gargalo

Usar `## Métricas por Camada` para guiar a análise:
- Backend: CPU, memória, I/O, queries N+1
- Frontend: LCP, FID, CLS (Core Web Vitals)
- Banco: índices ausentes, table scans, lock contention

### 4. Perfilar com ferramenta adequada

Consultar `## Ferramentas por Stack` para escolher a ferramenta correta para a linguagem/plataforma.

### 5. Implementar e validar a otimização

- Implementar **uma** otimização por vez
- Medir novamente com a mesma metodologia do passo 2
- Documentar o ganho obtido (ex: "P95 de 2.3s → 340ms após adição de índice")

### 6. Completar o checklist

Usar `## Checklist de Análise` antes de fechar o ciclo de otimização.

## Exemplos

### Análise de query lenta (PostgreSQL)

```sql
-- Identificar queries lentas
SELECT query, mean_exec_time, calls, total_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 10;

-- Analisar uma query específica
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT u.*, p.* FROM usuarios u
JOIN pedidos p ON p.usuario_id = u.id
WHERE u.email = 'user@example.com';

-- Resultado típico de problema: "Seq Scan" em tabela grande
-- Solução: CREATE INDEX idx_usuarios_email ON usuarios(email);
```

### Profiling de endpoint (Node.js)

```javascript
// Usando clinic.js
// $ npx clinic doctor -- node server.js
// $ npx clinic flame -- node server.js

// Ou com console.time para medição pontual
async function getUsuario(id) {
  console.time('db-query')
  const usuario = await db.findById(id)
  console.timeEnd('db-query')  // output: db-query: 245ms
  return usuario
}
```
