#!/usr/bin/env bash
#
# clean-start.sh -- Reset the .github directory and git remote for a fresh hackathon start.
#
# What it does:
#   1. Empties .github/copilot-instructions.md
#   2. Removes all custom agents from .github/agents/ (keeps .gitkeep)
#   3. Removes all custom skills from .github/skills/
#   4. Removes the git remote "origin" so you don't accidentally push to the template repo
#   5. Stages and commits the cleaned state so you start with a clean working tree
#
# Usage:
#   chmod +x scripts/clean-start.sh
#   ./scripts/clean-start.sh
#

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== Hackathon Clean Start ==="
echo ""

# 1. Empty copilot-instructions.md
INSTRUCTIONS_FILE="$REPO_ROOT/.github/copilot-instructions.md"
if [ -f "$INSTRUCTIONS_FILE" ]; then
    > "$INSTRUCTIONS_FILE"
    echo "[OK] Cleared .github/copilot-instructions.md"
else
    echo "[SKIP] .github/copilot-instructions.md not found"
fi

# 2. Remove custom agents (keep .gitkeep)
AGENTS_DIR="$REPO_ROOT/.github/agents"
if [ -d "$AGENTS_DIR" ]; then
    find "$AGENTS_DIR" -type f ! -name '.gitkeep' -delete
    echo "[OK] Removed custom agents from .github/agents/"
else
    echo "[SKIP] .github/agents/ not found"
fi

# 3. Remove custom skills
SKILLS_DIR="$REPO_ROOT/.github/skills"
if [ -d "$SKILLS_DIR" ]; then
    rm -rf "$SKILLS_DIR"/*
    echo "[OK] Removed custom skills from .github/skills/"
else
    echo "[SKIP] .github/skills/ not found"
fi

# 4. Remove git remote origin
if git -C "$REPO_ROOT" remote get-url origin &>/dev/null; then
    REMOTE_URL=$(git -C "$REPO_ROOT" remote get-url origin)
    git -C "$REPO_ROOT" remote remove origin
    echo "[OK] Removed git remote 'origin' (was: $REMOTE_URL)"
else
    echo "[SKIP] No git remote 'origin' found"
fi

# 5. Stage and commit the clean state
git -C "$REPO_ROOT" add -A
git -C "$REPO_ROOT" commit -m "Clean start: reset for hackathon" --quiet
echo "[OK] Committed clean state to local repo"

echo ""
echo "Done. Your repo is clean and committed locally."
echo "Next steps:"
echo "  1. Add your own remote:  git remote add origin <your-repo-url>"
echo "  2. Write your .github/copilot-instructions.md"
echo "  3. Push when ready:      git push -u origin main"
