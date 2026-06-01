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

**Why:** The pygments pin is mandatory — pymdown-extensions 10.14 passes `filename=None` for untitled code blocks and pygments 2.19+ crashes in `html.escape` on that, breaking the strict build in CI. `pygments==2.18.0` is the last release that handles it.

**Supersedes:** The theme choice in the 2026-04-28 "MkDocs and GitHub Pages docs publishing shape" decision — plain default theme replaced by Material. The build command (`mkdocs build --strict`), dependency manifest, and dedicated Pages workflow remain as decided there.

**Manual step (owner action required):** Set GitHub → Settings → Pages → Source = "GitHub Actions" once in the UI. This cannot be configured from code.

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

## Governance

- All meaningful changes require team consensus
- Document architectural decisions here
- Keep history focused on work, decisions focused on direction
