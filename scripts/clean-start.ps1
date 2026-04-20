#
# clean-start.ps1 -- Reset the .github directory and git remote for a fresh hackathon start.
#
# What it does:
#   1. Empties .github/copilot-instructions.md
#   2. Removes all custom agents from .github/agents/ (keeps .gitkeep)
#   3. Removes all custom skills from .github/skills/
#   4. Removes Squad workflows from .github/workflows/
#   5. Removes .github/prompts/
#   6. Removes .copilot/, .squad/, .playwright-mcp/, .gitattributes
#   7. Removes the git remote "origin" so you don't accidentally push to the template repo
#   8. Stages and commits the cleaned state so you start with a clean working tree
#
# Usage:
#   .\scripts\clean-start.ps1
#

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

Write-Host "=== Hackathon Clean Start ===" -ForegroundColor Cyan
Write-Host ""

# 1. Empty copilot-instructions.md
$InstructionsFile = Join-Path $RepoRoot ".github\copilot-instructions.md"
if (Test-Path $InstructionsFile) {
    Set-Content -Path $InstructionsFile -Value "" -NoNewline
    Write-Host "[OK] Cleared .github/copilot-instructions.md" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .github/copilot-instructions.md not found" -ForegroundColor Yellow
}

# 2. Remove custom agents (keep .gitkeep)
$AgentsDir = Join-Path $RepoRoot ".github\agents"
if (Test-Path $AgentsDir) {
    Get-ChildItem -Path $AgentsDir -File -Recurse |
        Where-Object { $_.Name -ne ".gitkeep" } |
        Remove-Item -Force
    Write-Host "[OK] Removed custom agents from .github/agents/" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .github/agents/ not found" -ForegroundColor Yellow
}

# 3. Remove custom skills
$SkillsDir = Join-Path $RepoRoot ".github\skills"
if (Test-Path $SkillsDir) {
    Get-ChildItem -Path $SkillsDir -Recurse | Remove-Item -Recurse -Force
    Write-Host "[OK] Removed custom skills from .github/skills/" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .github/skills/ not found" -ForegroundColor Yellow
}

# 4. Remove Squad GitHub workflows
$WorkflowsDir = Join-Path $RepoRoot ".github\workflows"
if (Test-Path $WorkflowsDir) {
    Remove-Item -Path $WorkflowsDir -Recurse -Force
    Write-Host "[OK] Removed .github/workflows/" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .github/workflows/ not found" -ForegroundColor Yellow
}

# 5. Remove .github/prompts
$PromptsDir = Join-Path $RepoRoot ".github\prompts"
if (Test-Path $PromptsDir) {
    Remove-Item -Path $PromptsDir -Recurse -Force
    Write-Host "[OK] Removed .github/prompts/" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .github/prompts/ not found" -ForegroundColor Yellow
}

# 6. Remove non-participant top-level directories and files
$CopilotDir = Join-Path $RepoRoot ".copilot"
if (Test-Path $CopilotDir) {
    Remove-Item -Path $CopilotDir -Recurse -Force
    Write-Host "[OK] Removed .copilot/" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .copilot/ not found" -ForegroundColor Yellow
}

$SquadDir = Join-Path $RepoRoot ".squad"
if (Test-Path $SquadDir) {
    Remove-Item -Path $SquadDir -Recurse -Force
    Write-Host "[OK] Removed .squad/" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .squad/ not found" -ForegroundColor Yellow
}

$PlaywrightDir = Join-Path $RepoRoot ".playwright-mcp"
if (Test-Path $PlaywrightDir) {
    Remove-Item -Path $PlaywrightDir -Recurse -Force
    Write-Host "[OK] Removed .playwright-mcp/" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .playwright-mcp/ not found" -ForegroundColor Yellow
}

$GitattributesFile = Join-Path $RepoRoot ".gitattributes"
if (Test-Path $GitattributesFile) {
    Remove-Item -Path $GitattributesFile -Force
    Write-Host "[OK] Removed .gitattributes" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .gitattributes not found" -ForegroundColor Yellow
}

# 7. Remove git remote origin
try {
    $RemoteUrl = git -C $RepoRoot remote get-url origin 2>$null
    if ($LASTEXITCODE -eq 0) {
        git -C $RepoRoot remote remove origin
        Write-Host "[OK] Removed git remote 'origin' (was: $RemoteUrl)" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] No git remote 'origin' found" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[SKIP] No git remote 'origin' found" -ForegroundColor Yellow
}

# 8. Stage and commit the clean state
git -C $RepoRoot add -A
git -C $RepoRoot commit -m "Clean start: reset for hackathon" --quiet
Write-Host "[OK] Committed clean state to local repo" -ForegroundColor Green

Write-Host ""
Write-Host "Done. Your repo is clean and committed locally." -ForegroundColor Cyan
Write-Host "Next steps:"
Write-Host "  1. Add your own remote:  git remote add origin <your-repo-url>"
Write-Host "  2. Write your .github/copilot-instructions.md"
Write-Host "  3. Push when ready:      git push -u origin main"
