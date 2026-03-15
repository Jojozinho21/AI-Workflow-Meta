#!/bin/bash
# Nucleo Workflow (Meta) — Installer
# Copia skills para ~/.claude/skills/

set -e

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.claude/skills"

echo "🔧 Nucleo Workflow — Instalando skills..."
echo ""

installed=0

for skill_dir in "$SOURCE_DIR"/*/; do
    skill_name=$(basename "$skill_dir")
    target="$SKILLS_DIR/$skill_name"

    mkdir -p "$target"
    cp -r "$skill_dir"* "$target/"
    echo "  ✅ $skill_name"
    installed=$((installed + 1))
done

echo ""
echo "✅ $installed skills instaladas em $SKILLS_DIR"
echo ""
echo "📋 Skills disponíveis:"
echo "  • /workflow-criar     — Criar nucleo novo do zero"
echo "  • /workflow-editar    — Editar nucleo existente"
echo "  • /workflow-analisar  — Analisar/auditar nucleo"
echo ""
echo "🚀 Pronto! Use os comandos acima no Claude Code."
