# Tasks — Todo

## Pendentes

<!-- Formato: - [ ] [ID] Descrição -->

- [ ] [CHORE-001] Transformar repositório de skills em repositório de agentes

## Tarefa: [CHORE-001] Transformar Repositório de Skills em Repositório de Agentes

### Specs
- **Escopo:** Reestruturar o repo para suportar a arquitetura completa de agentes do Copilot CLI (skills + custom agents + instruções lean). Criar estrutura de pastas, templates e esqueletos dos 14 agentes. Conteúdo de cada agente será preenchido manualmente.
- **Critérios de aceite:** Estrutura de pastas criada, template reescrito, 14 agentes com esqueletos, README e copilot-instructions.md atualizados.

### Plano
- [x] Reescrever `.system/template/SKILL.md` com spec completa
- [ ] Criar `.system/creating-agents/SKILL.md` (meta-agente)
- [ ] Criar 14 pastas de agentes em `.experimental/agents/` com `SKILL.md` + `.agent.md` esqueletos
- [ ] Criar pastas vazias com `.gitkeep`
- [ ] Reescrever `README.md`
- [ ] Atualizar `.github/copilot-instructions.md` (lean orchestrator)

### Post-Mortem
- Revisão completa da documentação do Copilot CLI revelou 7 mecanismos de customização distintos.
- Skills + Custom agents são complementares: skill = workflow detalhado, agent = persona com contexto próprio.
- Sub-instruções path-specific (`.github/instructions/`) permitem especialização por área técnica.

