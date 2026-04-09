# Lessons Learned

Registro de lições aprendidas durante o desenvolvimento e manutenção deste repositório.

---

<!-- Formato: [YYYY-MM-DD] [CATEGORIA] Descrição da lição -->

[2026-04-07] [ESTRUTURA] O CLI `npx skills add` (vercel-labs/skills) escaneia automaticamente as pastas `skills/`, `skills/.curated/`, `skills/.experimental/`, e `skills/.system/` dentro de um repositório GitHub. Cada skill é uma pasta contendo um `SKILL.md` com frontmatter YAML (campos obrigatórios: `name` e `description`).

[2026-04-09] [OPEN-STANDARD] O open standard agentskills.io define o formato oficial de SKILL.md: frontmatter YAML (name, description, license, compatibility, allowed-tools, metadata) + body markdown. Funciona cross-platform (Copilot, Claude, Cursor, Codex, etc.). Progressive disclosure: metadata → instructions → resources.

[2026-04-09] [BEST-PRACTICES] GitHub Blog "Lessons from 2,500 repos" identifica 6 áreas críticas para agents de qualidade: Commands, Testing, Project structure, Code style, Git/PR workflow, Explicit boundaries. Agents especialistas superam generalistas. Exemplos reais de código são mais eficazes que explicações em prosa.

[2026-04-09] [ARQUITETURA] Separar .agent.md (persona + delegação) de SKILL.md (workflow detalhado) é a decisão correta: agents são leves (50-150 linhas) para caber no contexto, skills são ricas (100-300 linhas) para guiar execução. ADR-001 documenta esta decisão.
