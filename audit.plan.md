# Plano de Refatoração: Arquitetura Estrita de Orquestrador (Hub-and-Spoke)

## Objetivo
Realizar uma varredura completa no repositório de agentes e skills para garantir total coerência arquitetural. O agente `principal` deve ser o único orquestrador da equipe. Nenhuma delegação, escalonamento ou comunicação ("reunião") deve ocorrer diretamente entre agentes especialistas; tudo deve fluir obrigatoriamente através do `principal`, que gerenciará o estado do trabalho usando o `todo.md`.

## Arquivos Chave & Contexto
- **Regras Globais:** `.github/copilot-instructions.md`
- **Agente Orquestrador:** `skills/.experimental/agents/principal.agent.md`
- **Agentes Especialistas:** Todos os 16 arquivos em `skills/.experimental/agents/*.agent.md`
- **Skills (Workflows):** Todos os arquivos `SKILL.md` em `skills/.experimental/skills/`
- **Templates de Sistema:** `skills/.system/template/SKILL.md`, `skills/.system/creating-agents/SKILL.md`

## Plano de Implementação

### 0. Exportar Plano
- Salvar este plano de auditoria e refatoração em `D:\dev\skills\audit.plan.md`.

### 1. Refatorar Regras Globais e Templates
- **`.github/copilot-instructions.md`:** 
  - Remover orientações de escalonamento direto (ex: "chamar architect antes de implementar").
  - Reforçar que a arquitetura é "Hub-and-Spoke": o `principal` atua como tech lead e gerente de projeto em "reuniões", sendo o único responsável por consultar o `todo.md` e direcionar as tarefas.
- **`.system/template/SKILL.md` & `.system/creating-agents/SKILL.md`:**
  - Garantir que a regra de "não comunicar diretamente com outros agentes" esteja clara e que a terminologia seja estritamente `principal`.

### 2. Padronizar o Agente Orquestrador (`principal`)
- **`principal.agent.md`:** Revisar o texto para assegurar que o fluxo de "Reunião" (handoffs sucessivos, recebimento de relatórios e delegação sequencial) está detalhado de forma inequívoca e que ele detém o monopólio da gestão do `todo.md` e `history.md`.

### 3. Refatorar Agentes Especialistas (16 arquivos)
- **Eliminar Delegação Direta:** Buscar todas as ocorrências de `Consultar [agente]`, `Escalar para [agente]`, `Delegar para [agente]` (ex: `Consultar specs-collector`, `Delegar para test-driven-developer`) e alterá-las para `Reportar ao principal a necessidade de [ação] do [agente]`.
- **Padronizar Nomenclatura:** Substituir menções a `orquestrador` ou `agente orquestrador` por `principal` para manter o léxico coerente em todo o repositório.
- **Workflow Padrão (Fechamento):** Adicionar ou alterar o último passo do fluxo de trabalho de *todos* os agentes especialistas para: `Reportar ao principal a conclusão da tarefa com um resumo, permitindo que ele atualize o todo.md e inicie o próximo passo da reunião.`.

### 4. Revisar as Skills (Workflows)
- Varrer todos os `SKILL.md` dentro de `.experimental/skills/` para remover qualquer traço remanescente de comunicação direta entre especialistas ou redundâncias na execução de tarefas que pertençam ao orquestrador.

## Verificação e Testes
- **Varredura Final (Grep):** Executar buscar por padrões como `Consultar \``, `Delegar para \``, `Escalar para \``, `Informar ao orquestrador` para garantir que `0` ocorrências restem fora do arquivo `principal.agent.md`.
- **Validação de Conformidade:** Rodar o script `scripts/validate.sh` (se existir) para assegurar que os arquivos YAML frontmatters e Markdowns permanecem válidos.
- **Revisão Manual Aleatória:** Checar 2-3 agentes (ex: `backend`, `devops`, `ui-ux-specialist`) para confirmar que a nova dinâmica de equipe flui naturalmente para o `principal`.