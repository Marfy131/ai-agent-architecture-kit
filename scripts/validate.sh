#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

SKILLS_DIR="$ROOT_DIR/.agents/skills"
AGENTS_MD="$ROOT_DIR/AGENTS.md"
MANIFEST_MD="$ROOT_DIR/MANIFEST.md"
README_MD="$ROOT_DIR/README.md"

ERRORS=0

echo "Validating ai-agent-architecture-kit..."

for dir in "$SKILLS_DIR"/*/; do
  skill_dir="${dir%/}"
  skill_name="$(basename "$skill_dir")"
  skill_file="$skill_dir/SKILL.md"

  if [[ ! -f "$skill_file" ]]; then
    echo "ERROR: Missing SKILL.md in $skill_dir" >&2
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check frontmatter
  if ! head -n 1 "$skill_file" | grep -q "^---$"; then
    echo "ERROR: Missing frontmatter start in $skill_file" >&2
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -q "^name: $skill_name$" "$skill_file"; then
    echo "ERROR: Frontmatter name in $skill_file does not match '$skill_name'" >&2
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -q "^description:" "$skill_file"; then
    echo "ERROR: Missing description in $skill_file" >&2
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -q "\`$skill_name\`" "$AGENTS_MD"; then
    echo "ERROR: Skill '$skill_name' is missing from AGENTS.md" >&2
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -q -- "- \`$skill_name\`" "$MANIFEST_MD"; then
    echo "ERROR: Skill '$skill_name' is missing from MANIFEST.md" >&2
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -q "$skill_name/SKILL.md" "$README_MD"; then
    echo "ERROR: Skill '$skill_name' is missing from README.md" >&2
    ERRORS=$((ERRORS + 1))
  fi
done

# Check templates
for tmpl in "templates/backend/AGENTS.md" "templates/backend/ARCHITECTURE.md" "templates/frontend/AGENTS.md" "templates/frontend/ARCHITECTURE.md"; do
  if [[ ! -s "$ROOT_DIR/$tmpl" ]]; then
    echo "ERROR: Missing or empty template: $tmpl" >&2
    ERRORS=$((ERRORS + 1))
  fi
done

if [[ $ERRORS -gt 0 ]]; then
  echo "Validation failed with $ERRORS errors." >&2
  exit 1
fi

echo "All skills, templates, and documentation cross-references verified successfully!"
exit 0
