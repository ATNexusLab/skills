# Lessons Learned

Registro de lições aprendidas durante o desenvolvimento e manutenção deste repositório.

---

<!-- Formato: [YYYY-MM-DD] [CATEGORIA] Descrição da lição -->

[2026-04-07] [ESTRUTURA] O CLI `npx skills add` (vercel-labs/skills) escaneia automaticamente as pastas `skills/`, `skills/.curated/`, `skills/.experimental/`, e `skills/.system/` dentro de um repositório GitHub. Cada skill é uma pasta contendo um `SKILL.md` com frontmatter YAML (campos obrigatórios: `name` e `description`).
