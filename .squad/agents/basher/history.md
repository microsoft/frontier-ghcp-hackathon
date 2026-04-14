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
