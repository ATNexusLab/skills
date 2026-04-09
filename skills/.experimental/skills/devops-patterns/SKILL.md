---
name: devops-patterns
description: Use quando precisar configurar CI/CD, Docker, infraestrutura como código, estratégias de deploy ou gerenciamento de ambientes. Padrões e boas práticas de DevOps.
---

# DevOps Patterns

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Configurar pipelines de CI/CD
- Criar ou otimizar Dockerfiles e docker-compose
- Definir estratégia de deploy (blue-green, canary, rolling)
- Configurar infraestrutura como código (IaC)
- Gerenciar secrets e variáveis de ambiente
- Configurar ambientes (dev, staging, production)

## CI/CD Pipeline

### Estrutura Recomendada

```
Install → Lint → Build → Test → Security → Deploy
```

**Princípios:**
- **Fail fast** — lint e testes unitários primeiro, E2E por último
- **Reprodutível** — mesmo commit, mesmo resultado, sempre
- **Incremental** — cache de dependências entre runs
- **Seguro** — secrets nunca em logs, scan de vulnerabilidades automático

### GitHub Actions — Padrões

```yaml
# Estrutura recomendada
name: CI
on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version-file: '.node-version'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint

  test:
    needs: lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version-file: '.node-version'
          cache: 'npm'
      - run: npm ci
      - run: npm test

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm run build
```

**Boas práticas:**
- Fixar versões de actions (`@v4`, não `@latest`)
- Usar cache de dependências (`cache: 'npm'`)
- Separar jobs para paralelismo (lint || test, deploy sequencial)
- Branch protection: exigir CI verde para merge

## Docker

### Dockerfile Multi-Stage

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Stage 2: Runtime
FROM node:20-alpine AS runtime
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
USER node
CMD ["node", "dist/index.js"]
```

**Boas práticas:**
- Multi-stage builds — imagem final menor e mais segura
- `.dockerignore` configurado (node_modules, .git, tests)
- Rodar como usuário não-root (`USER node`)
- Healthcheck configurado
- Versões específicas de imagens base (não `latest`)

### Docker Compose — Desenvolvimento

```yaml
services:
  app:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: app_dev
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: dev
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U dev"]
      interval: 5s
      timeout: 5s
      retries: 5
```

## Estratégias de Deploy

| Estratégia | Risco | Rollback | Quando Usar |
|------------|-------|----------|-------------|
| **Rolling** | Médio | Lento | Default, mudanças incrementais |
| **Blue-Green** | Baixo | Instantâneo | Mudanças de alto risco, zero downtime |
| **Canary** | Baixo | Rápido | Validar com subset de tráfego antes |
| **Recreate** | Alto | Lento | Mudanças que exigem downtime (migrations destrutivas) |

**Regras:**
- Sempre ter rollback plan antes de deployar
- Migrations de banco separadas do deploy de código
- Feature flags para mudanças arriscadas (deploy ≠ release)
- Smoke tests automatizados pós-deploy

## Secrets Management

**Nunca:**
- Secrets no código ou em repositório
- Secrets em logs ou output de CI
- Secrets em variáveis de ambiente não criptografadas em produção

**Sempre:**
- Usar secret managers (GitHub Secrets, AWS Secrets Manager, HashiCorp Vault)
- Rotacionar secrets periodicamente
- Princípio de menor privilégio (cada serviço só acessa o que precisa)
- Auditar acesso a secrets

## Ambientes

| Ambiente | Propósito | Dados |
|----------|-----------|-------|
| **Development** | Desenvolvimento local | Dados fake/seed |
| **Staging** | Validação pré-produção | Dados anonimizados de produção |
| **Production** | Usuários reais | Dados reais, backup obrigatório |

**Regras:**
- Staging deve ser o mais próximo possível de production
- Nunca usar dados reais de produção em desenvolvimento
- Feature flags para controlar rollout gradual
- Observabilidade (logs, métricas, traces) em todos os ambientes

## Checklist de Infraestrutura

- [ ] CI/CD pipeline configurado e testado
- [ ] Dockerfile otimizado (multi-stage, non-root, healthcheck)
- [ ] Secrets gerenciados por secret manager
- [ ] Rollback plan documentado e testado
- [ ] Monitoramento e alertas configurados
- [ ] Backup e disaster recovery planejados
- [ ] Branch protection rules ativas
- [ ] Ambientes isolados (dev, staging, prod)
