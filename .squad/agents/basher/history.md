# Basher — History

## Core Context

- Project: GitHub Copilot Enterprise Hackathon challenge repo
- Owner: Marco Olivo
- Devcontainer configs under .devcontainer/ -- one per challenge (challenge-0 through challenge-5, plus bonus)
- Clean-start scripts (scripts/clean-start.sh, scripts/clean-start.ps1) wipe .github/ and detach remote
- Setup scripts (scripts/setup-challenge.sh, scripts/setup-challenge.ps1) for challenge-specific init
- Codespaces is primary delivery -- containers must boot fast and clean
- Tooling per challenge: Node.js, Python 3.11, .NET 8.0, Terraform, Docker-in-Docker, Jupyter, etc.
- VS Code workspace settings in .vscode/

## Learnings

- Added step 5 to both clean-start scripts (`.sh` and `.ps1`): after wiping `.github/` contents and removing the remote, the scripts now run `git add -A` and `git commit` to give participants a committed baseline. Previously the cleanup left uncommitted changes floating in the working tree, which is messy for people unfamiliar with git. The commit message is "Clean start: reset for hackathon". Updated header comments and closing output to match.

📌 Team update (2026-04-28): Docs publishing is expected to use a dedicated GitHub Pages workflow with the same `mkdocs build --strict` command used locally. Treat MkDocs validation as part of the deployment contract, not an optional local check. -- decided by Scribe

- (2026-05-14) `.gitattributes` had zero eol rules -- only Squad merge-driver entries. Windows clones with `core.autocrlf=true` were injecting CRLF into all `.sh` files, breaking shebangs (`bad interpreter: /usr/bin/env bash^M`). Fixed by prepending `* text=auto eol=lf`, `*.sh text eol=lf`, and `*.ps1 text eol=crlf` before the Squad section. Ran `git add --renormalize .` to re-normalize already-checked-out files. Verified with `git check-attr` (all three scripts/\*.sh now show `eol: lf`) and `git ls-files --eol` (all show `i/lf w/lf`). Affected files confirmed clean: `scripts/setup-challenge.sh`, `scripts/clean-start.sh`, `scripts/_clean-common.sh`, `challenges/challenge-14-pipeline-factory/scripts/deploy.sh`, `.devcontainer/challenge-19-wcf-banking/setup-wcf.sh`, `.devcontainer/challenge-11-mumps-banking/setup-yottadb.sh`, `.devcontainer/challenge-18-cobol-banking/setup-gnucobol.sh`, `.squad/templates/skills/distributed-mesh/sync-mesh.sh`, `.copilot/skills/distributed-mesh/sync-mesh.sh`.
