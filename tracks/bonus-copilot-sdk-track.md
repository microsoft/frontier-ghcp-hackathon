# Bonus Track: Copilot SDK Developer

**Duration:** 8-12 hours (Advanced)

**Difficulty:** ⭐⭐⭐

**Focus:** Building a Release Notes Agent from scratch using the GitHub Copilot SDK

> ⚠️ **This is a bonus track.** It is significantly harder and longer than the standard 4-6 hour tracks. It is designed for experienced developers who have completed a standard track (or equivalent) and want a deeper challenge that goes beyond using Copilot -- to **building with its engine**.

## Who Is This For

- Developers who finished a standard track and want more
- Backend engineers interested in AI-powered tooling
- Platform/DevEx engineers who want to embed Copilot's agentic capabilities in custom apps
- Anyone curious about programmatic access to Copilot's agent runtime

## Prerequisites

- Completion of at least one standard track (or equivalent experience)
- Solid Node.js and TypeScript skills
- Familiarity with GitHub APIs (Issues, Pull Requests, Releases, Tags)
- Understanding of event-driven and streaming patterns
- Copilot CLI installed and authenticated (`copilot --version` should work)

## Technology Stack

- **Runtime:** Node.js (LTS) with TypeScript
- **SDK:** `@github/copilot-sdk` -- programmatic access to Copilot's agent runtime (sessions, streaming, custom tools)
- **GitHub API:** `@octokit/rest` -- for querying PRs, releases, tags, commits, and CI status
- **Copilot CLI:** Required as the backend server -- the SDK communicates with it via JSON-RPC
- **Deployment:** Azure (App Service or Container Apps) for the final application

## What You Are Building

**"ship-it" -- a Release Notes Agent.** Given a repository and a reference point (a tag, a date, or a commit SHA), this CLI agent analyzes all merged pull requests, categorizes the changes, generates a structured changelog, and can publish a draft GitHub Release. The workflow is conversational -- a team lead can review the generated notes, ask for adjustments ("move this PR to the highlights section", "add a migration guide for the breaking change"), and iterate until they are satisfied. When everything looks right, they say "publish it" and the agent creates the release.

This is the kind of repetitive-but-judgement-requiring task where an agent with tools genuinely outperforms a plain script. Nobody likes writing release notes by hand, but a script can't categorize changes intelligently or draft human-readable summaries. The SDK sits right in the middle.

## Getting Started

### 1. Open the Challenge

Open the folder `challenges/bonus-1-copilot-sdk/` in your workspace.

A dedicated devcontainer is provided at `.devcontainer/bonus-1-copilot-sdk/`. It includes Node.js LTS, Copilot CLI, and GitHub CLI. Open the command palette (`F1` > **Dev Containers: Reopen in Container**) and select **bonus-1-copilot-sdk** when prompted.

### 2. Install and Run

```bash
cd challenges/bonus-1-copilot-sdk
npm install
npx tsx index.ts
```

### 3. Authenticate with Copilot CLI

Make sure you are logged in via Copilot CLI before running the SDK:

```bash
copilot auth login
copilot --version
```

The SDK manages the CLI process lifecycle automatically. You do not need to start the CLI server manually.

### 4. Clean Start and Custom Instructions

Follow the [common setup steps](getting-started.md) for the clean start. Then write custom instructions relevant to building Copilot SDK applications -- include context about `CopilotClient`, session management, custom tool definitions, and the event-based streaming model. Also add context about the release notes domain: PR categorization conventions, changelog formatting, and GitHub Release creation.

---

## Phases

| Phase | Name | Est. Time | What You Build |
|-------|------|-----------|----------------|
| 1 | [Foundation](bonus-copilot-sdk-track/phase-1-foundation.md) | 2-3 hours | Client setup, streaming, interactive release scope confirmation |
| 2 | [Core Features](bonus-copilot-sdk-track/phase-2-core-features.md) | 3-4 hours | PR fetching tools, change categorization, changelog generation |
| 3 | [Advanced Features](bonus-copilot-sdk-track/phase-3-advanced-features.md) | 2-3 hours | MCP integration, release publishing, iterative refinement |
| 4 | [Production-Ready](bonus-copilot-sdk-track/phase-4-production.md) | 1-2 hours | Testing, packaging, Azure deployment |

## Tips for Using Copilot on This Track

**Use Copilot to build a Copilot-powered app -- meta!**

- Ask Copilot to help you define custom tool schemas for the SDK -- start with "Define a tool schema that fetches merged PRs between two git refs"
- Use `/explain` on the SDK types to understand the session event model
- Ask: *"How should I categorize pull requests into features, fixes, breaking changes, and internal changes based on labels and title prefixes?"*
- Use Agent mode to scaffold the full tool registration and event handling in one go
- When building the changelog formatter, ask Copilot to generate templates matching popular formats (Keep a Changelog, GitHub's auto-generated notes style)

## Resources

### Copilot SDK

- [Copilot SDK Repository](https://github.com/github/copilot-sdk) -- source code, docs, and examples for all languages
- [Getting Started Guide](https://docs.github.com/en/copilot/how-tos/copilot-sdk/sdk-getting-started) -- official quickstart
- [SDK Blog Post](https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/) -- architecture overview and use cases
- [Copilot SDK Cookbook](https://github.com/github/awesome-copilot/blob/main/cookbook/copilot-sdk) -- practical recipes for common patterns
- [Node.js Custom Instructions](https://github.com/github/awesome-copilot/blob/main/instructions/copilot-sdk-nodejs.instructions.md) -- Copilot instructions tuned for Node.js SDK development

### GitHub Documentation

- [Copilot CLI Installation](https://docs.github.com/en/copilot/how-tos/copilot-cli/install-copilot-cli)
- [Copilot SDK Overview](https://docs.github.com/en/copilot/how-tos/copilot-sdk)
- [Premium Requests and Billing](https://docs.github.com/en/copilot/concepts/billing/copilot-requests)

### General

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
