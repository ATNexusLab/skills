---
name: frontend-implementation
description: Use quando precisar implementar componentes, páginas, formulários ou interfaces web. Fornece padrões de componentização, acessibilidade e qualidade de UI.
type: skill
targets: [copilot-cli, gemini-cli, antigravity]
---

# Frontend Implementation

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Criar ou atualizar componentes UI
- Implementar páginas ou fluxos de usuário
- Integrar com APIs (fetch, state management)
- Melhorar acessibilidade ou performance de frontend

## Passos

### 1. Entender o contexto UI

Antes de implementar:
- Verificar design system ou componentes existentes — não reinventar o que existe
- Ler a spec de UX se disponível (chamar `ux-specification` se não houver)
- Verificar convenções do projeto: framework, estilo (CSS modules, Tailwind, styled-components)

### 2. Componentização

- Componente deve ter **uma responsabilidade** clara
- Separar: lógica de negócio vs. apresentação
- Props explícitas com tipos definidos
- Sem lógica de estado global onde local resolve

### 3. Acessibilidade obrigatória

- Elementos interativos com `aria-label` quando texto não é suficiente
- Foco gerenciado corretamente (modais, dropdowns)
- Contraste de cor mínimo WCAG AA (4.5:1 para texto normal)
- Navegação por teclado funcional
- Formulários com labels associados aos inputs

### 4. Performance

- Evitar re-renders desnecessários (memoization quando justificado)
- Imagens com dimensões e lazy loading
- Sem bloqueio de renderização no critical path
- Bundle size: importar apenas o que usa (tree shaking)

### 5. Integração com API

- Tratar estados: loading, success, error
- Feedback visual para o usuário em todas as transições
- Não expor erros internos da API para o usuário final
- Cache de dados quando fizer sentido

### 6. Checklist pré-entrega

- [ ] Componente funciona em mobile e desktop
- [ ] Acessível via teclado
- [ ] Estados de loading e erro implementados
- [ ] Testes de componente cobrindo comportamentos principais
- [ ] Sem console.error ou warnings no browser
- [ ] Lint passando
