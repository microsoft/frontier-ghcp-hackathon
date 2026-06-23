# Rusty — History

## Core Context

- Project: GitHub Copilot Enterprise Hackathon challenge repo
- Owner: Marco Olivo
- 7 core tracks + 11 bonus tracks, each with stage files under the track directories in `tracks/`
- Track structure defined in tracks/TRACK_STRUCTURE.md (section order is mandatory)
- Writing style: .github/copilot-instructions.md -- no emoji headings, no em-dashes, no AI slop, no hype, natural developer voice
- Shared setup: tracks/getting-started.md (clean start, custom instructions, agents, open challenge)
- Stage files: Tasks (numbered), Verification (bullets), navigation footer (Previous/Next)
- Challenge folders have no README -- all instructions live in track files
- Azure-only constraint
- Content must describe WHAT to achieve, never provide ready-to-paste solutions

## Learnings

- (2026-06-15) Challenge 21 enrichment should make participants defend Terraform decisions, not build a bigger platform. Keep the scope to Azure Container Apps, remote state, network shape, managed identity and Key Vault, module reuse, CI policy, and drift response. Require short docs artifacts for plan review and trade-offs so the work cannot be completed by accepting generated HCL alone.

📌 Team update (2026-04-28): The docs site can add a curated entry layer for ordering and navigation, but the publishing path should stay lightweight and share one strict MkDocs build path with CI and GitHub Pages. -- decided by Scribe

📌 Correction note (2026-04-28): The repo now uses a single numbered challenge sequence through Challenge 18. Any older references to bonus tracks or bonus challenges in this history are historical only and should not be used for current work.

- (2026-06-12) The current catalog now extends through Challenge 21. Challenge 21 is the dedicated Azure Terraform track, with stage content focused on remote state, Azure platform setup, managed identity and Key Vault, module reuse, and CI plus drift handling. When updating docs that summarize the challenge range, keep the prose aligned with the table and repo structure.

- (2026-06-12) Challenge 21 follows the specialized-track phase convention, not the stage convention. Use `phase-*` filenames and Phase labels for its track sub-pages, and keep final newlines in every phase file for markdownlint hygiene.

- (2026-06-23) Created the data layer for the bespoke hackathon site: 22 `meta.yml` files (one per challenge folder) following the locked schema from SITE_CONTRACT.md, plus a root `learning-paths.json` with 8 curated paths. Meta.yml schema: id (challenge-N), number, title, category (one of 5 locked category ids: core-tracks, team-sprints, legacy-modernization, workflow-automation, azure-platform), difficulty (beginner/intermediate/advanced), duration_minutes (integer midpoint of track Duration), description (one plain-text sentence for cards), focus (from track), tags (from challenges.json), prerequisites (empty array unless track explicitly requires an earlier challenge), track_url, starter_path. Category mapping: Core tracks=0-8, Team sprints=9-10, Legacy modernization=11,12,18,19, Workflow automation=13-17,20, Azure platform=21. Difficulty derived from track stars: mostly ⭐->beginner, ⭐⭐->intermediate, ⭐⭐⭐+->advanced. Duration midpoints: 4-6h->300, 6-8h->420, 6-10h->480, 8-10h->540, 8-12h->600. Learning paths: Core Developer Journey, Full-Stack Mastery, Legacy Modernization, Automation Excellence, Team Collaboration, AI & ML Development, Azure Infrastructure, Advanced Workflows. Every challenge_id referenced in learning-paths.json is a real id from challenge-0 through challenge-21.

- (2026-06-23) README.md updated for bespoke site: replaced all MkDocs references with bespoke static site structure, updated Challenge Set Builder references to point to published site builder.html and paths.html instead of deleted markdown docs, added Documentation Site section describing `node web/build.js` workflow and local preview via `python3 -m http.server`, all coach workflow links now reference site builder and learning-paths pages, verified no MkDocs artifact references remain.
