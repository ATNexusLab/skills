---
name: performance-analysis
description: Use quando precisar identificar gargalos de performance, fazer profiling, benchmarks ou otimizações em backend, frontend ou banco de dados.
type: skill
targets: [copilot-cli, gemini-cli, antigravity]
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
