#!/usr/bin/env bash
# validate.sh — Valida estrutura de agentes e skills do repositório
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AGENTS_DIR="$REPO_ROOT/skills/.experimental/agents"
SKILLS_DIR="$REPO_ROOT/skills/.experimental/skills"
ERRORS=0

red()   { printf "\033[31m%s\033[0m\n" "$1"; }
green() { printf "\033[32m%s\033[0m\n" "$1"; }
yellow(){ printf "\033[33m%s\033[0m\n" "$1"; }

echo "🔍 Validando repositório ATNexusLab/skills..."
echo ""

# 1. Validar agents (.agent.md)
echo "=== AGENTS ==="
for agent_file in "$AGENTS_DIR"/*.agent.md; do
  name=$(basename "$agent_file" .agent.md)
  
  # Check frontmatter exists
  if ! head -1 "$agent_file" | grep -q "^---"; then
    red "❌ $name.agent.md — sem frontmatter YAML"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check required fields
  for field in name description tools; do
    if ! grep -q "^${field}:" "$agent_file"; then
      red "❌ $name.agent.md — campo '$field' ausente no frontmatter"
      ERRORS=$((ERRORS + 1))
    fi
  done

  # Check line count
  lines=$(wc -l < "$agent_file")
  if [ "$lines" -gt 150 ]; then
    yellow "⚠️  $name.agent.md — $lines linhas (ideal: 50-150)"
  fi

  # Check required sections
  for section in "Protocolo de Escalamento" "Fluxo de Trabalho" "Nunca Faça"; do
    if ! grep -q "$section" "$agent_file"; then
      red "❌ $name.agent.md — seção '$section' ausente"
      ERRORS=$((ERRORS + 1))
    fi
  done

  green "✅ $name.agent.md ($lines linhas)"
done

echo ""

# 2. Validar skills (SKILL.md)
echo "=== SKILLS ==="
for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name=$(basename "$skill_dir")
  skill_file="$skill_dir/SKILL.md"

  if [ ! -f "$skill_file" ]; then
    red "❌ $skill_name/ — SKILL.md ausente"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check frontmatter
  if ! head -1 "$skill_file" | grep -q "^---"; then
    red "❌ $skill_name/SKILL.md — sem frontmatter YAML"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check required fields
  for field in name description; do
    if ! grep -q "^${field}:" "$skill_file"; then
      red "❌ $skill_name/SKILL.md — campo '$field' ausente"
      ERRORS=$((ERRORS + 1))
    fi
  done

  lines=$(wc -l < "$skill_file")
  if [ "$lines" -gt 300 ]; then
    yellow "⚠️  $skill_name/SKILL.md — $lines linhas (ideal: 100-300)"
  fi

  green "✅ $skill_name/SKILL.md ($lines linhas)"
done

echo ""

# 3. Validar system skills
echo "=== SYSTEM ==="
for sys_dir in "$REPO_ROOT/skills/.system"/*/; do
  sys_name=$(basename "$sys_dir")
  sys_file="$sys_dir/SKILL.md"

  if [ ! -f "$sys_file" ]; then
    red "❌ .system/$sys_name/ — SKILL.md ausente"
    ERRORS=$((ERRORS + 1))
    continue
  fi
  
  lines=$(wc -l < "$sys_file")
  green "✅ .system/$sys_name/SKILL.md ($lines linhas)"
done

echo ""

# 4. Summary
echo "=== RESUMO ==="
agent_count=$(ls "$AGENTS_DIR"/*.agent.md 2>/dev/null | wc -l)
skill_count=$(find "$SKILLS_DIR" -name "SKILL.md" | wc -l)
echo "Agentes: $agent_count"
echo "Skills:  $skill_count"

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  red "💥 $ERRORS erro(s) encontrado(s)"
  exit 1
else
  echo ""
  green "🎉 Tudo validado com sucesso!"
  exit 0
fi
