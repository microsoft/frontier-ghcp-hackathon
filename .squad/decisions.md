# Squad Decisions

## Active Decisions

### 2026-06-01: MkDocs nav nesting convention for track sub-pages

**By:** Danny (Lead), requested by Marco Olivo

**What:** Every challenge track in `mkdocs.yml` `nav:` that has sub-pages is expanded into a nav SECTION rather than a single link. The section's first entry is always `Overview:` pointing to the main `tracks/challenge-N-...-track.md` page. Then:
- Stage-based challenges (0,1,2,3,4,5,6,20): list `Stage N - <Title>` entries in numeric order.
- Single-file phase challenges (7,8,11-19): list `Phase N - <Title>` entries in numeric order.
- Sprint challenges (9 and 10): each phase is itself a nested sub-section containing an `Overview:` (the `phase-*.md` file) plus the per-role pages. Role order is fixed: Product Owner, Business Analyst, Frontend Developer, Backend Developer, QA Engineer, DevOps Engineer (Challenge 10 omits PO/BA).

**Title rules:** Single ` - ` separator (matches existing "Challenge N - Title" style), no em-dashes, no emoji, concise human titles derived from filename or H1.

**Verification:** `docs/tracks` is a symlink to `tracks/`; enumerate with `find -L docs/tracks -name '*.md'`. Every track page must appear in nav exactly once. Confirm with `. .venv-docs/bin/activate && mkdocs build --strict` -> must exit 0 with no warnings.

**Why:** User wants all per-stage/per-phase/per-role pages browsable on the GitHub Pages site, not just top-level track pages. Future track additions must follow this nesting + ordering convention and re-run the strict build before merging.

### 2026-06-01: GitHub Pages docs use Material for MkDocs

**By:** Basher (DevOps), requested by Marco Olivo

**What:** Upgraded the docs site from the plain default MkDocs theme to Material for MkDocs (navigation tabs/sections/top, light/dark palette toggle, search suggest/highlight, code copy) so the published GitHub Pages site renders tracks, challenges, and guides as a polished, navigable website. Pinned `mkdocs-material==9.5.49`, `pymdown-extensions==10.14`, and `pygments==2.18.0` in `requirements-docs.txt`. The existing `.github/workflows/deploy-docs.yml` is unchanged. `mkdocs build --strict` passes (exit 0).

**Why:** The pygments pin is mandatory -- pymdown-extensions 10.14 passes `filename=None` for untitled code blocks and pygments 2.19+ crashes in `html.escape` on that, breaking the strict build in CI. `pygments==2.18.0` is the last release that handles it.

**Supersedes:** The theme choice in the 2026-04-28 "MkDocs and GitHub Pages docs publishing shape" decision -- plain default theme replaced by Material. The build command (`mkdocs build --strict`), dependency manifest, and dedicated Pages workflow remain as decided there.

**Manual step (owner action required):** Set GitHub → Settings → Pages → Source = "GitHub Actions" once in the UI. This cannot be configured from code.

### 2026-06-12: Challenge 21 is a dedicated Azure Terraform track with its own scaffold and devcontainer

**By:** Danny, Rusty, Basher

**What:** Added Challenge 21 as `challenge-21-azure-terraform`, positioned as a dedicated Azure Terraform track separate from the broader DevOps track. The track is a 4-6 hour Azure-only path focused on remote state, Azure platform setup, managed identity and Key Vault, module reuse, and CI plus drift handling. The corresponding challenge scaffold lives under `challenges/challenge-21-azure-terraform/terraform/azure`, ships with a dedicated lean devcontainer, and includes a valid Azure starter that provisions a resource group plus a private storage account and container for Terraform state exercises.

**Guardrail:** When a challenge scaffold lands before its track guide, `scripts/setup-challenge.sh` and `scripts/setup-challenge.ps1` must preserve shared `tracks/` content instead of deleting it or leaving a broken README link.

**Why:** The repository already covered Terraform inside the broader DevOps track, but it did not have a Terraform-first Azure infrastructure path. This isolates infrastructure authoring and review work into its own workshop-ready challenge without duplicating the container and Kubernetes scope from Challenge 3.

### 2026-06-12: Challenge 21 phase naming and Terraform root

**By:** Danny (Lead), requested by Marco Olivo

**What:** Challenge 21 uses `phase-*` track files and Phase labels in navigation, matching the specialized track convention used by nearby challenges 17-19. The participant Terraform working root is `challenges/challenge-21-azure-terraform/terraform/azure`; duplicate root-level Terraform files under `terraform/` were consolidated into that path or removed.

**Why:** Challenge 21 had both `stage-*` track pages and two Terraform roots, which made it look different from the specialized tracks and gave participants two possible places to work. The track, devcontainer, workflow, and starter files now point to one clear path.

### 2026-06-15: Challenge 21 requires Terraform review judgment

**By:** Danny, Rusty, Basher, Livingston, requested by Scribe

**What:** Challenge 21 should be richer by adding realistic Azure Terraform judgment pressure, not by expanding the platform footprint. Keep it Azure-only, phase-based, and centered on `challenges/challenge-21-azure-terraform/terraform/azure`, with Azure Container Apps as the canonical hosting target. The track now expects participants to resolve ambiguous stakeholder requirements, review Terraform plans before apply, document rejected options, justify identity and access choices, define environment promotion rules, and handle drift or failed applies through a short incident runbook.

**Scaffold guardrails:** The starter should stay intentionally incomplete enough to require decisions rather than copy-paste completion. It may include constrained variables, Azure naming and tagging guardrails, backend access choices, validation hooks, CI lint placeholders, drift evidence, and compact review docs. It should not add Kubernetes, Azure Container Registry, a full app build, complex multi-region deployment, private endpoint implementation, enterprise landing-zone scaffolding, production-grade policy suites, extra cloud providers, challenge-folder README files, or stage naming.

**4-6 hour cap:** Keep deliverables to five phase-sized increments: state and naming, network and Container Apps environment, identity and Key Vault design, module and environment cleanup, and CI plus drift response. New artifacts should sharpen existing work rather than add a sixth phase.

**Why:** The previous Challenge 21 flow was structurally sound but too linear. A participant could ask an AI assistant to generate Terraform phase by phase and pass most checks. The richer pattern rewards reasoning about naming, state, modules, identity, policy severity, plan review, and drift response while staying workshop-sized.

### 2026-06-12: Challenge selection copy must stay aligned with the current catalog range

**By:** Livingston, Danny

**What:** Any update to `docs/challenge-selection.md` that expands or renumbers the challenge table must also update the surrounding instructional copy so the stated challenge range matches the table and repo structure.

**Why:** Reviewer validation caught a mismatch where Step 1 still referenced an older challenge range after the catalog had expanded, which made the selection flow inconsistent even though the table itself was current.

### 2026-05-04: Challenge 19 uses CoreWCF on .NET 8 (not classic WCF/.NET Framework)

**By:** Linus, Basher (via Coordinator)

**What:** Challenge 19 runs the WCF banking service using CoreWCF on .NET 8, not classic WCF/.NET Framework. Classic WCF requires Windows containers (not Codespaces-compatible). CoreWCF is Linux-native and installs via NuGet (CoreWCF.Http 1.5+).

**Why:** Codespaces runs Linux containers. Classic WCF on .NET Framework requires Windows Server containers, which GitHub Codespaces does not support. CoreWCF provides the same service contract programming model on .NET 8 on Linux.

### 2026-04-28: MkDocs and GitHub Pages docs publishing shape (consolidated)

**By:** Rusty, Basher, Danny

**What:** Use plain MkDocs for the documentation site with a small curated entry layer, a root-level docs dependency manifest, and a dedicated GitHub Pages workflow. Keep the docs build command the same locally and in CI with `mkdocs build --strict`.

**Why:** This keeps the docs stack small, avoids unnecessary theme or plugin churn, and gives the team one validation path for both local work and Pages deployment. The curated entry layer can shape the reader flow without requiring a heavy second documentation system.

### 2026-04-28: Normalize squad metadata to the renumbered challenge model

**By:** Danny

**What:** Treat the renumbered repository model as the source of truth in mutable squad metadata and charters. Use one numbered challenge sequence instead of the old core-versus-bonus split.

**Why:** The repository already uses the renumbered Challenge 0 through Challenge 18 structure. Keeping squad metadata on the old split causes avoidable drift when agents describe project scope or challenge paths.

### 2026-06-23: Bespoke site architecture replacing MkDocs

**By:** Marco, decided by Linus (foundation), Rusty (data), Basher (infra)

**What:** Migrated the GitHub Pages site from MkDocs (Python build, CLI workflow) to a bespoke Node.js static site consuming challenge metadata as sources of truth. The architecture includes:

- `web/build.js` — dependency-free Node build script reading `challenges/*/meta.yml` and `learning-paths.json`, transforming to `platform.json`, `paths.json`, and challenge guides
- `web/assets/js/core.js` — locked FP API providing data loading, URL builders, badge generators, kiosk mode support (consumed by all page scripts without modification)
- `web/assets/css/styles.css` — 5-category color scheme (core-tracks, team-sprints, legacy-modernization, workflow-automation, azure-platform) with utility classes
- Shared header/footer shell in `web/index.html` + `web/assets/js/home.js` (copied verbatim by all other pages)
- 22 `meta.yml` files (one per challenge): category, difficulty (beginner/intermediate/advanced), duration (minutes), prerequisites, tags
- 8 learning paths in `learning-paths.json` (Core Developer Journey, Full-Stack Mastery, Legacy Modernization, Automation Excellence, Team Collaboration, AI & ML Development, Azure Infrastructure, Advanced Workflows)
- New `.github/workflows/deploy-site.yml` workflow (triggers on push to main + workflow_dispatch, runs build.js, deploys from web/ to GitHub Pages)
- Deleted MkDocs infrastructure: `mkdocs.yml`, `requirements-docs.txt`, `site/`, `scripts/generate-challenge-catalog.py`, old curator pages/assets in docs/
- Kept consumed pages: `docs/copilot-guide.md`, `docs/prompt-engineering.md`, `docs/mcp-servers.md`, `docs/images/`, `FACILITATOR_GUIDE.md`, `TROUBLESHOOTING.md`, `tracks/getting-started.md`

**Pages implemented:**
- Catalog (`catalog.html`/`catalog.js`) — filterable, searchable access to 22 challenges, deep links via ?cat=<id> and ?difficulty=<level>
- Challenge detail (`challenge.html`/`challenge.js`/`challenge.css`) — renders challenge hero, metadata, prerequisites, guide content; kiosk-aware (preserves ?set param on internal links)
- Builder (`builder.html`/`builder.js`) — coaches multi-select challenges by category/difficulty/search, generate shareable student set URL via FP.setUrl()
- Student set view (`set.html`/`set.js`) — displays curated challenges from ?ids=comma-separated, auto-enters kiosk mode (hides nav, injects exit button)
- Learning paths (`paths.html`/`paths.js`/`paths.css`) — displays 8 curated paths with challenge lists and share-as-set controls
- Guides (`guide.html`/`guide.js`/`guide.css`) — renders markdown pages (?p=<slug>) with sidebar navigation

**Category mappings:** "Core tracks" → core-tracks (0-8), "Team sprints" → team-sprints (9-10), "Legacy modernization" → legacy-modernization (11,12,18,19), "Workflow automation" → workflow-automation (13-17,20), "Azure platform" → azure-platform (21)

**Difficulty mappings:** ⭐ → beginner, ⭐⭐ → intermediate, ⭐⭐⭐+ → advanced; progressive ranges rounded to representative level

**Duration mappings:** 4-6h → 300min, 6-8h → 420min, 6-10h → 480min, 8-10h → 540min, 8-12h → 600min

**Why:** The MkDocs static generation step was slow and tightly coupled to documentation structure. A bespoke build allows us to:
- Use challenge metadata as single source of truth (no duplication across mkdocs.yml and challenge folders)
- Generate multiple static sites (catalog, builder, guides) from one data set
- Implement student set feature (coaches create custom challenge collections, students see locked views) without complex MkDocs plugins
- Migrate to Azure-backed deployment in the future without changing the local development workflow
- Speed up the build process (no mkdocs virtualenv or CLI overhead)

**Verification:** Build passes (22 challenges, 5 categories, 8 learning paths), all 9 JavaScript files pass `node --check`, Markdownlint 0 errors, no dangling MkDocs references, Azure-only references maintained.

**Pre-existing issues flagged (out of scope):** Challenges 1, 2, 11, 18, 19 have folder/track/devcontainer naming mismatches. Recommended for future Gentry/Marco resolution to standardize naming conventions.

**Manual step (owner action required):** Set GitHub → Settings → Pages → Source = "GitHub Actions" once in the UI (if not already done).

## Governance

- All meaningful changes require team consensus
- Document architectural decisions here
- Keep history focused on work, decisions focused on direction
