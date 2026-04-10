# Lessons Learned

Registro de lições aprendidas durante o desenvolvimento e manutenção deste repositório.

---

<!-- Formato: [YYYY-MM-DD] [CATEGORIA] Descrição da lição -->

[2026-04-07] [ESTRUTURA] O CLI `npx skills add` (vercel-labs/skills) escaneia automaticamente as pastas `skills/`, `skills/.curated/`, `skills/.experimental/`, e `skills/.system/` dentro de um repositório GitHub. Cada skill é uma pasta contendo um `SKILL.md` com frontmatter YAML (campos obrigatórios: `name` e `description`).

[2026-04-09] [OPEN-STANDARD] O open standard agentskills.io define o formato oficial de SKILL.md: frontmatter YAML (name, description, license, compatibility, allowed-tools, metadata) + body markdown. Funciona cross-platform (Copilot, Claude, Cursor, Codex, etc.). Progressive disclosure: metadata → instructions → resources.

[2026-04-09] [BEST-PRACTICES] GitHub Blog "Lessons from 2,500 repos" identifica 6 áreas críticas para agents de qualidade: Commands, Testing, Project structure, Code style, Git/PR workflow, Explicit boundaries. Agents especialistas superam generalistas. Exemplos reais de código são mais eficazes que explicações em prosa.

[2026-04-09] [ARQUITETURA] Separar .agent.md (persona + delegação) de SKILL.md (workflow detalhado) é a decisão correta: agents são leves (50-150 linhas) para caber no contexto, skills são ricas (100-300 linhas) para guiar execução. ADR-001 documenta esta decisão.

[2026-04-09] [REVIEW] Ao criar agentes que mostram comandos executáveis no workflow (EXPLAIN, mongosh, head, etc.), sempre incluir "execute" no array de tools do frontmatter. Ferramenta declarada no frontmatter deve cobrir tudo que o fluxo de trabalho descreve. Review de produção encontrou 3 agentes (sql-dba, nosql-dba, instructions-expert) com mismatch tools/workflow.

[2026-04-09] [PATHS] Arquivos operacionais do repo (todo.md, history.md, lessons.md) vivem em `.github/tasks/`, não em `tasks/`. Agentes devem sempre referenciar o path completo `.github/tasks/` para evitar ambiguidade. Review encontrou 8+ ocorrências do path incorreto em 3 agentes originais.

[2026-04-09] [GENERICIDADE] Skills e agentes NUNCA devem referenciar paths hardcoded de um projeto específico (ex: `docs/context/architecture.md`). O repo é genérico — skills/agents devem usar instruções de discovery ("buscar documentação do projeto") em vez de assumir estrutura de diretórios. Encontradas 15+ ocorrências em 7 arquivos.

[2025-07-11] [FRONTMATTER] O campo `infer` está DEPRECATED no spec oficial do VS Code/.agent.md. Substituído por dois campos: `user-invocable: true` (visibilidade no dropdown de chat) + `disable-model-invocation: false` (permite invocação como subagente pelo principal). SEMPRE incluir ambos em todos os .agent.md.

[2025-07-11] [FRONTMATTER] O `principal.agent.md` ficou com frontmatter quebrado (faltava `---` de fechamento após `user-invocable: true`). Sem o `---`, todo o body era interpretado como YAML. Verificar fechamento de frontmatter ao criar/editar qualquer .agent.md.

[2025-07-11] [ESTRUTURA] Seção `## Metodologia` vazia antes de sub-seções de conteúdo é anti-padrão. Se a metodologia não tem texto próprio, usar o nome da primeira sub-seção diretamente (ex: `## Princípios`, `## Checklist`). Encontrado em todos os 18 agentes — removido na varredura de julho/2025.

[2026-04-10] [ARQUITETURA] copilot-instructions.md deve ser Camada 1 pura (constituição): contexto, idioma, stack, convenções e referências. Qualquer conteúdo operacional (roster, protocolos, workflows) pertence ao principal.agent.md (Camada 2). Misturar camadas é o erro mais comum e cria duplicação e conflito silencioso.

