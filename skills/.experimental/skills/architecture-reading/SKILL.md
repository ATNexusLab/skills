---
name: architecture-reading
description: Use quando precisar entender a arquitetura atual de um projeto antes de tomar decisões ou iniciar implementação. Mapeia stack, fronteiras, padrões e decisões existentes.
---

# Architecture Reading

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Antes de qualquer decisão arquitetural em um projeto existente
- Quando um agente precisa entender o contexto técnico atual
- Ao iniciar uma nova tarefa em codebase desconhecido
- Para validar se uma nova decisão conflita com decisões anteriores

## Passos

### 1. Localizar documentação de contexto existente

Procurar nesta ordem:
```
docs/context/architecture.md
docs/context/stack.md
docs/context/conventions.md
docs/context/decisions/          ← ADRs e decisões anteriores
README.md
```

Se não existir nada: registrar que o projeto **não tem contexto documentado** e recomendar criar.

### 2. Mapear a stack tecnológica

Ler os arquivos de configuração do projeto:
```
package.json / pom.xml / build.gradle / Cargo.toml / go.mod / pyproject.toml
docker-compose.yml / Dockerfile
.env.example
```

Extrair: linguagem, frameworks, bancos de dados, serviços externos, versões principais.

### 3. Identificar fronteiras do sistema

Mapear:
- Quais são os módulos/serviços principais?
- Como eles se comunicam (HTTP, eventos, filas, RPC)?
- Quais são as dependências externas?
- Onde ficam as fronteiras de domínio?

### 4. Identificar padrões arquiteturais em uso

Verificar evidências de:
- Padrão de camadas (MVC, Clean Architecture, Hexagonal)?
- Separação de responsabilidades (repositórios, serviços, controllers)?
- Padrões de comunicação (REST, GraphQL, eventos)?
- Padrões de dados (CQRS, Event Sourcing)?

### 5. Consolidar o relatório de leitura

Produzir um resumo estruturado com:
```markdown
## Stack
[linguagem, frameworks, bancos]

## Fronteiras
[módulos e como se comunicam]

## Padrões Identificados
[padrões arquiteturais em uso]

## Decisões Anteriores Relevantes
[ADRs encontrados que impactam a tarefa atual]

## Lacunas Documentais
[o que não está documentado e deveria estar]
```

## Quando Não Existe Documentação

Se o projeto não tem `docs/context/`, registrar claramente:

> "Projeto sem documentação arquitetural. Análise baseada em inferência de código.
> Recomendo criar `docs/context/architecture.md` com o resultado desta leitura."

## Referências

- Templates de documentação arquitetural: `references/`
- Exemplos de relatórios de leitura: `examples/`
