# Work Routing

How to decide who handles what.

## Routing Table

| Work Type | Route To | Examples |
|-----------|----------|----------|
| Track structure, architecture, sync decisions | Danny | New track planning, section order changes, cross-file sync validation |
| Track/stage content, writing, markdown prose | Rusty | Write stage files, edit track descriptions, fix writing style issues |
| Challenge starter code, multi-language implementation | Linus | Add starter code, fix challenge scaffolding, update code examples |
| Devcontainers, scripts, CI/CD, Docker | Basher | New devcontainer config, fix clean-start script, add workflow |
| Lint compliance, quality checks, PR review | Livingston | Run markdownlint, validate track structure, verify sync rules |
| Code review | Danny + Livingston | Review PRs -- Danny for architecture, Livingston for quality |
| Scope & priorities | Danny | What to build next, trade-offs, decisions |
| Session logging | Scribe | Automatic -- never needs routing |

## Issue Routing

| Label | Action | Who |
|-------|--------|-----|
| `squad` | Triage: analyze issue, assign `squad:{member}` label | Danny |
| `squad:danny` | Architecture, sync, structure decisions | Danny |
| `squad:rusty` | Track/stage content writing | Rusty |
| `squad:linus` | Challenge code implementation | Linus |
| `squad:basher` | Devcontainer/script/CI work | Basher |
| `squad:livingston` | Quality checks, lint, review | Livingston |

### How Issue Assignment Works

1. When a GitHub issue gets the `squad` label, the **Lead** triages it — analyzing content, assigning the right `squad:{member}` label, and commenting with triage notes.
2. When a `squad:{member}` label is applied, that member picks up the issue in their next session.
3. Members can reassign by removing their label and adding another member's label.
4. The `squad` label is the "inbox" — untriaged issues waiting for Lead review.

## Rules

1. **Eager by default** — spawn all agents who could usefully start work, including anticipatory downstream work.
2. **Scribe always runs** after substantial work, always as `mode: "background"`. Never blocks.
3. **Quick facts → coordinator answers directly.** Don't spawn an agent for "what port does the server run on?"
4. **When two agents could handle it**, pick the one whose domain is the primary concern.
5. **"Team, ..." → fan-out.** Spawn all relevant agents in parallel as `mode: "background"`.
6. **Anticipate downstream work.** If a feature is being built, spawn the tester to write test cases from requirements simultaneously.
7. **Issue-labeled work** — when a `squad:{member}` label is applied to an issue, route to that member. The Lead handles all `squad` (base label) triage.
