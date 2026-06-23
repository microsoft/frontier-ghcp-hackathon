# Linus — History

## Core Context

- Project: GitHub Copilot Enterprise Hackathon challenge repo
- Owner: Marco Olivo
- Challenge folders under challenges/ -- 7 core + 11 bonus
- Multi-language: Node.js/TS (backend, SDK), Python (data science, flight delay), Terraform (DevOps), React/TS (frontend), .NET (QA)
- Starter code must scaffold without solving -- guide, don't hand-hold
- Each challenge has a matching devcontainer config under .devcontainer/
- Azure-only constraint for any cloud references
- No README files in challenge folders -- instructions live in tracks/

## Learnings

## Learnings

### 2026-06-23: Web foundation build

**Layout**: The `web/` directory contains the bespoke static site for the GitHub Copilot Enterprise Hackathon. Structure is:

- `web/build.js` — dependency-free Node build script (core modules only).
- `web/index.html` + `web/assets/js/home.js` — home page with canonical shared header/footer shell.
- `web/assets/js/core.js` — FP API providing data loading, theme, nav, kiosk, reveal, markdown rendering.
- `web/assets/js/marked.min.js` — copied verbatim from reference repo.
- `web/assets/css/styles.css` — adapted from reference, using 5 category colors instead of 4 module colors.
- `web/assets/data/` — GENERATED, git-ignored; contains `platform.json`, `paths.json`, challenge guides, and content pages.

**FP API surface** (locked contract in `core.js`):

- `FP.loadData()` → Promise(platform.json), cached.
- `FP.loadPaths()` → Promise(paths.json), cached.
- `FP.categoryColor(id)`, `FP.categoryName(id, categories)` → map category IDs to CSS vars and names.
- `FP.challengeUrl(id)`, `FP.catalogUrl(catId)`, `FP.guideUrl(slug)`, `FP.setUrl(ids, name)` → URL builders.
- `FP.diffBadge(d)`, `FP.durBadge(mins)`, `FP.tagBadges(tags, limit)` → HTML badge generators.
- `FP.kioskParams()`, `FP.isKiosk()`, `FP.applyKiosk()`, `FP.kioskChallengeUrl(id, params)` → curated set support.
- `FP.initTheme()`, `FP.initNav()`, `FP.initReveal()`, `FP.renderError(el, msg)` → UI initialization.
- `FP.renderMd(raw, el)`, `FP.renderInlineMd(raw)` → markdown rendering with sanitization.
- Auto-init on DOMContentLoaded: theme, nav, kiosk, reveal.

**build.js inputs/outputs**:

- **Inputs**: `challenges/<slug>/meta.yml` (single source of truth for each challenge), `learning-paths.json` (repo root), track markdown files (`tracks/<name>.md` + stage/phase files).
- **Outputs**:
  - `web/assets/data/platform.json` — full catalog (categories + challenges with category, category_name, difficulty, duration, description, focus, tags, prerequisites, track_url, starter_path, guide path).
  - `web/assets/data/paths.json` — curated learning paths.
  - `web/assets/data/challenges/<id>/guide.md` — concatenated guide (main track + stage/phase files in order).
  - `web/assets/data/pages/<slug>.md` — content docs (copilot-guide, prompt-engineering, mcp-servers, facilitator-guide, troubleshooting, getting-started).
- **Validation**: every meta.yml has required fields; category is one of the 5; every learning-path challenge_id and prerequisites[] entry resolves; exits non-zero on error.
- **Category metadata** is hardcoded in build.js per the contract.

**Deviations from reference**:

- Renamed `module` → `category` throughout (5 categories vs 4 modules).
- Single hackathon branding: "GitHub Copilot Enterprise Hackathon" (no four-module compass).
- Category IDs and colors per contract: `core-tracks` (#58a6ff), `team-sprints` (#3fb950), `legacy-modernization` (#d29922), `workflow-automation` (#a371f7), `azure-platform` (#ec6547).
- Added `FP.loadPaths()` for learning paths support.
- Home page leads with 5 categories + curated paths, not modules + outcomes.
- CSS utility classes: `.cat-<id>` with `--cat-color` instead of `.mod-<id>` with `--mod-color`.

**Testing**: Build runs clean with test stubs. When real meta.yml files land, the build will populate platform.json and paths.json automatically. Other agents own authoring those files.

### 2026-06-23: Student set feature and multi-page site delivery

**Pages delivered**: Implemented 5 page pairs (HTML + JS + optional CSS) on the locked FP API foundation:

1. **Catalog page** (`catalog.html`, `catalog.js`) — filterable/searchable 22-challenge grid, grouped by category with live counts, deep links (?cat=<id>, ?difficulty=<level>), all FP.* helpers reused, no custom CSS.

2. **Challenge detail page** (`challenge.html`, `challenge.js`, `challenge.css`) — single view for any challenge reading ?id param, renders hero/metadata sidebar/prerequisites/guide content, fetches guide markdown via FP.renderMd(), handles kiosk mode (preserves ?set param on internal links to keep students in curated set), scoped CSS for typography and layout only.

3. **Builder page** (`builder.html`, `builder.js`) — coaches multi-select challenges via category/difficulty/search filters, track selection state in a Set, generate shareable student set URL using FP.setUrl(), copy/open buttons for sharing, all FP.* helpers reused, no custom CSS.

4. **Student set page** (`set.html`, `set.js`) — displays curated challenges from ?ids=comma-separated param, auto-enters kiosk mode (hides nav links, injects exit button, preserves kiosk state on challenge links), challenges grouped by category, empty states (no ids → link to builder, unknown ids → silent filter, no valid → error message).

5. **Learning paths page** (`paths.html`, `paths.js`, `paths.css`) — loads 8 curated paths from paths.json, resolves challenge IDs to titles, renders path cards with challenge lists and share-as-set controls (absolute URL via FP.setUrl()), copy/open buttons.

6. **Guide page** (`guide.html`, `guide.js`, `guide.css`) — reads ?p=<slug> param (defaults to copilot-guide), fetches markdown from assets/data/pages/<slug>.md, renders via FP.renderMd() with marked.js, sidebar nav lists all guides with active state highlighting, unknown slug shows FP.renderError().

**Kiosk mode**: The feature that allows coaches to lock student views to a specific challenge set. Implemented via FP.kioskParams() (extracts ?set=<set_id> from URL), FP.isKiosk() (true if in kiosk), FP.applyKiosk() (hides nav, footer, injects exit button), and FP.kioskChallengeUrl(id, params) (constructs links that preserve kiosk state). Set and challenge pages auto-enter kiosk mode if ?set param is present; all internal links preserve it so students never accidentally escape to the full catalog.

**Technical invariants**: All pages copy header/footer verbatim from index.html to ensure consistent branding and nav. No edits to core.js, build.js, styles.css, or sibling pages. Reused all existing CSS classes from styles.css (.card, .btn, .badge, .sel-card, .set-tray, .filters, .challenge-grid, etc.). All URL generation, data loading, markdown rendering, and kiosk logic delegated to FP.* helpers without modification. JavaScript syntax validated with `node --check` for all 9 files.

**Governance note**: The locked FP API and shared shell pattern allowed 5 page pairs to be developed in parallel without merge conflicts or coordination overhead. Build.js + core.js + home shell form the immutable foundation; all other pages are additive layers that cannot break each other. Future page additions should follow the same pattern.
