# Livingston -- History

## Core Context

- Project: GitHub Copilot Enterprise Hackathon challenge repo
- Owner: Marco Olivo
- 18 tracks total (7 core + 11 bonus) must follow TRACK_STRUCTURE.md
- Markdownlint config at .markdownlint.json
- Writing style rules at .github/copilot-instructions.md
- Sync rules: track ↔ challenge ↔ devcontainer ↔ README.md
- Stage files need: Tasks (numbered), Verification (bullets), navigation footer
- No emoji in headings, no em-dashes, no AI slop, no hype, code fences need lang tags
- Azure-only constraint

## Learnings

📌 Team update (2026-04-28): MkDocs and GitHub Pages changes should be validated with `mkdocs build --strict`, and docs link or navigation fixes count as release-blocking if they break the curated site flow. -- decided by Scribe

- (2026-06-12) Challenge-selection reviews need to check both the table rows and the instructional prose around them. Catalog drift can show up as stale range wording even when the table itself is correct.

- (2026-06-12) Challenge 21 consistency review: missing final newlines in phase files are release-blocking markdown hygiene. After newline-only cleanup, focused markdownlint passed for the Challenge 21 track files.

- (2026-06-15) Challenge 21 richness review approved the enriched Azure Terraform path as workshop-sized. Future reviews should check that infrastructure challenges include judgment evidence, such as rejected generated suggestions, plan consequences, identity trade-offs, CI gate reasoning, and drift response, without turning into a full landing-zone build.

- (2026-06-23) QA review of bespoke site migration: comprehensive validation covering markdownlint (0 errors after em-dash fixes), writing style compliance (no emoji/em-dashes/hype, Azure-only), build integrity (`node web/build.js` passes with 22 challenges/5 categories/8 paths), dangling MkDocs references (0 matches), JS syntax (9 files pass `node --check`). Pre-existing issues flagged (out of scope for migration): challenges 1, 2, 11, 18, 19 have folder/track/devcontainer naming mismatches; recommended for future Gentry/Marco resolution. Web/README.md fixed (em-dashes replaced with --). Migration validated as release-ready.
