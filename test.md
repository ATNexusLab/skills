# Cenário de Teste: Arquitetura Hub-and-Spoke no Copilot CLI

Este é um plano de teste prático para você executar no `copilot-cli` (ou na interface do GitHub Copilot que suporta agents/skills) e validar se a nova arquitetura "Hub-and-Spoke" está funcionando como esperado.

O objetivo deste teste é simular uma situação complexa que exija várias especialidades, forçando o `principal` a assumir a liderança e coordenar a "reunião", sem que os agentes falem diretamente uns com os outros.

---

## 🧪 O Teste: Criação de um Endpoint Complexo sem Spec

**Copie e cole o seguinte prompt para o seu orquestrador:**

> "@principal Preciso que você implemente um endpoint `POST /api/v1/checkout` para processar pagamentos. O banco principal é PostgreSQL, mas precisamos salvar a sessão do carrinho no Redis. Tem que ser super performático e cobrir todos os casos de teste. Pode fazer tudo pra mim?"

---

## 🎯 Comportamento Esperado (O que observar)

Se a arquitetura Hub-and-Spoke estiver funcionando perfeitamente, o fluxo deve ocorrer da seguinte forma:

### 1. Ativação do Orquestrador e Planejamento
O `principal` deve ser o primeiro a responder. Ele **não deve** começar a escrever código ou tomar decisões arquiteturais.
- **Ação:** Ele criará um plano inicial listando as tarefas (ex: 1. Especificar regras de checkout, 2. Modelar DB, 3. Desenvolver Backend, 4. Escrever Testes).
- **Validação:** Ele deve registrar o plano no `.github/tasks/todo.md`.

### 2. Delegação Inicial: Levantamento de Requisitos
Como a requisição não tem regras de negócio claras (ex: payload do checkout), o `principal` deve reportar que acionará o `specs-collector` (ou perguntar a você para suprir as informações).
- **Ação do Especialista:** O `specs-collector` levanta as perguntas ou esboça a spec.
- **A Prova do Hub-and-Spoke:** O `specs-collector` **NÃO DEVE** chamar o `backend` para implementar. O último passo dele será **"Reportar ao principal que a spec está pronta ou necessita de aprovação"**.

### 3. Retorno ao `principal` e Atualização de Estado
- **Ação:** O `principal` recebe a spec, marca a tarefa de especificação como concluída `[x]` no `todo.md`, move para o `history.md` e inicia a próxima etapa (a delegação para o banco de dados).

### 4. Delegação: Modelagem de Dados
- **Ação:** O `principal` aciona o `sql-dba` para a modelagem PostgreSQL e o `nosql-dba` para o cache Redis.
- **A Prova do Hub-and-Spoke:** Os DBAs devem focar unicamente em criar schemas/migrations e padrões de acesso, e então **reportar de volta ao principal** ao concluir. Eles não devem instruir o backend.

### 5. Delegação: Implementação e Testes
- **Ação:** O `principal` delega a implementação para o `backend` (passando a spec e os modelos de dados).
- **A Prova do Hub-and-Spoke:** Se o código precisar de cobertura de testes, o `backend` **NÃO** deve acionar diretamente o `test-driven-developer`. Ele deve reportar a conclusão da implementação ao `principal`. Em seguida, o `principal` orquestra a chamada ao `test-driven-developer`.

### 6. Síntese Final
- O `principal` encerra a "reunião", atualiza as lições aprendidas em `lessons.md`, faz um relatório final do que foi entregue por cada especialista e pede sua avaliação do resultado.

---

## 🚩 Red Flags (Critérios de Falha)

Se você notar qualquer um destes comportamentos, a arquitetura estrita foi violada:
1. Comunicação Direta: Um agente dizendo *"Estou chamando o agente X..."* ou *"Delegando para Y..."* (apenas o `principal` pode fazer isso).
2. Violação de Estado: Qualquer agente especialista criando ou modificando o `todo.md` ou `history.md` (essa é função exclusiva do orquestrador).
3. Execução Prematura: Um agente especialista (`backend` ou `sql-dba`) tentar implementar sem que o `principal` tenha orquestrado a entrega da especificação primeiro.