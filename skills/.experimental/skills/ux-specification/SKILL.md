---
name: ux-specification
description: Use quando precisar criar especificações de UX, fluxos de usuário, critérios de acessibilidade ou avaliar decisões de interface. Não implementa — especifica.
type: skill
targets: [copilot-cli, gemini-cli, antigravity]
---

# UX Specification

> ⚠️ EXPERIMENTAL — Ainda não validado em produção.

## Quando Usar

- Definir o fluxo de um usuário antes de implementar
- Especificar comportamento de componentes UI complexos
- Definir critérios de acessibilidade para uma feature
- Avaliar se uma decisão de interface está adequada

## Perguntas de Discovery UX

Antes de especificar qualquer interface:

- **Quem é o usuário?** — Perfil, contexto, dispositivo principal
- **Qual é o objetivo?** — O que o usuário quer realizar?
- **Qual é o caminho mais curto?** — Quantas etapas são necessárias?
- **O que pode dar errado?** — Estados de erro, loading, vazio
- **É acessível?** — Usuários com deficiências visuais, motoras ou cognitivas conseguem usar?

## Formato de Especificação de Fluxo

```markdown
## Fluxo: [Nome do Fluxo]

### Persona
[Quem é o usuário neste fluxo]

### Objetivo
[O que o usuário quer alcançar]

### Pré-condições
[O que precisa ser verdade antes de iniciar]

### Caminho Principal (Happy Path)
1. Usuário faz X
2. Sistema mostra Y
3. Usuário faz Z
4. Sistema confirma e redireciona para W

### Caminhos Alternativos
- **Caso A:** Se [condição], então [comportamento]
- **Caso B:** Se [condição], então [comportamento]

### Estados de Erro
- **Erro de validação:** [mensagem exibida, campo destacado]
- **Erro de servidor:** [mensagem genérica, sem detalhes técnicos]
- **Timeout:** [feedback visual + opção de retry]

### Estados de Loading
- [Qual feedback visual durante operação assíncrona]

### Estado Vazio
- [O que mostrar quando não há dados]
```

## Critérios de Acessibilidade (WCAG 2.1 AA)

### Obrigatórios
- **Contraste:** texto normal ≥ 4.5:1, texto grande ≥ 3:1
- **Teclado:** todos os elementos interativos acessíveis via Tab
- **Labels:** todo input tem label associado (não só placeholder)
- **Alt text:** toda imagem informativa tem descrição
- **Foco visível:** indicador de foco sempre visível
- **Sem dependência de cor:** não usar cor como único meio de informação

### Formulários
- Erros de validação próximos ao campo com problema
- Mensagem de erro descritiva ("Email inválido" > "Erro")
- Campos obrigatórios marcados visualmente E com `aria-required`

### Navegação
- Skip links para conteúdo principal
- Landmarks (`main`, `nav`, `header`, `footer`)
- Heading hierarchy lógica (h1 → h2 → h3)

## Padrões de Feedback Visual

| Situação | Feedback Esperado |
|----------|------------------|
| Ação assíncrona | Spinner ou skeleton, desabilitar botão |
| Sucesso | Confirmação positiva com próximo passo claro |
| Erro de validação | Inline, próximo ao campo, em vermelho com ícone |
| Erro de sistema | Toast/banner com mensagem amigável + retry |
| Lista vazia | Ilustração + ação sugerida (não só "Sem resultados") |
| Confirmação destrutiva | Modal de confirmação, não ação imediata |

## Nunca Faça (UX)

- Nunca usar só cor para transmitir informação crítica
- Nunca fazer ação destrutiva sem confirmação explícita
- Nunca usar placeholder como substituto de label
- Nunca criar modais que bloqueiam sem forma clara de fechar
- Nunca mover foco de forma inesperada sem avisar o usuário
