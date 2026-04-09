---
name: github-operations
description: Use quando precisar executar operações no GitHub via CLI ou API: criar issues, PRs, releases, gerenciar branches, labels, milestones e workflows.
---

# GitHub Operations

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Criar ou gerenciar issues e pull requests
- Criar releases e tags
- Gerenciar branches, labels e milestones
- Verificar status de workflows e CI
- Automatizar operações repetitivas no GitHub

## Operações Comuns

### Issues
```bash
# Criar issue
gh issue create --title "Título" --body "Descrição" --label "bug"

# Listar issues
gh issue list --state open --label "bug"

# Fechar issue
gh issue close <número>
```

### Pull Requests
```bash
# Criar PR
gh pr create --title "feat: descrição" --body "## O que muda\n..." --base main

# Verificar status de checks
gh pr checks <número>

# Aprovar PR
gh pr review <número> --approve

# Fazer merge
gh pr merge <número> --squash --delete-branch
```

### Releases
```bash
# Criar release com tag
gh release create v1.2.3 --title "Release 1.2.3" --notes "## Changelog\n..."

# Listar releases
gh release list
```

### Branches
```bash
# Criar e mudar para branch
git checkout -b feat/nome-da-feature

# Listar branches remotas
git branch -r

# Deletar branch remota (após merge)
git push origin --delete feat/nome-da-feature
```

### Workflows (GitHub Actions)
```bash
# Listar runs do workflow
gh run list --workflow ci.yml

# Ver logs de um run
gh run view <run-id> --log

# Re-rodar workflow falho
gh run rerun <run-id>
```

## Convenções de Nomenclatura

### Branches
```
feat/nome-descritivo
fix/nome-do-bug
chore/nome-da-tarefa
docs/nome-da-doc
```

### Commits (Conventional Commits)
```
feat: adiciona autenticação JWT
fix: corrige cálculo de desconto para produtos sem estoque
chore: atualiza dependências de segurança
docs: adiciona exemplos de uso da API
```

### Labels de Issue
```
bug         — comportamento incorreto
enhancement — melhoria de feature existente
feature     — nova funcionalidade
chore       — manutenção, dependências
security    — vulnerabilidade ou hardening
docs        — documentação
```

## Checklist antes de criar PR

- [ ] Branch atualizada com a base (main/develop)
- [ ] Commits com mensagens descritivas (Conventional Commits)
- [ ] CI passando localmente (`npm test`, `go test ./...`, etc.)
- [ ] Descrição do PR explica o quê, por quê e como testar
- [ ] Issue relacionada linkada (`Closes #123`)
- [ ] Sem commits de debug, console.log ou arquivos temporários
