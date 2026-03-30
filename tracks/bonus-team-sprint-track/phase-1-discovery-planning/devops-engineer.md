# Phase 1: Discovery and Planning -- DevOps Engineer Tasks

[Back to Phase 1 Overview](../phase-1-discovery-planning.md) | [Back to Team Sprint Track](../../bonus-team-sprint-track.md)

**Time: ~1 hour setup + 30 min planning**

## Tasks

1. **Set up the repository structure** -- Define branching strategy (trunk-based or feature branches). Write a short doc in `docs/branching-strategy.md` with the team's agreement on PR conventions.

2. **Create the backend Dockerfile** -- Write a multi-stage Dockerfile for the backend. Include a dev stage with hot reload and a production stage.

3. **Create docker-compose.yml** -- Set up local development with docker-compose that runs the backend (and later the frontend and database).

4. **Set up GitHub Actions** -- Create a CI workflow (`.github/workflows/ci.yml`) that runs on PRs. Start with a lint step and a placeholder test step.

5. **Write custom instructions** -- Add DevOps context to `.github/copilot-instructions.md`: Docker conventions, compose service names, CI/CD approach, and how the local stack is structured.

6. **Create an infra agent** -- Create `.github/agents/infra-engineer.agent.md` with Docker Compose, GitHub Actions, and local networking context. Include the names and ports of each service in the compose file.

7. **Sprint planning** -- Join the PO's planning session. Confirm infrastructure timeline.

## Verification

- [ ] Backend Dockerfile working
- [ ] docker-compose running the backend locally
- [ ] GitHub Actions CI workflow runs on PRs

---

Next: [Phase 2 -- DevOps Engineer Tasks](../phase-2-sprint-1-build/devops-engineer.md)
