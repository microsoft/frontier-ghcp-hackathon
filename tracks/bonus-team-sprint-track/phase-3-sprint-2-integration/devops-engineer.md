# Phase 3: Sprint 2 -- DevOps Engineer Tasks

[Back to Phase 3 Overview](../phase-3-sprint-2-integration.md) | [Back to Team Sprint Track](../../bonus-team-sprint-track.md)

**Time: Full 2 hours**

## Tasks

1. **Add a reverse proxy** -- Add an nginx (or Traefik) service to `docker-compose.yml` that sits in front of the backend and frontend. Route `/api/` to the backend and everything else to the frontend. This removes the need for the frontend to know the backend's port at runtime.

2. **Make the stack shareable** -- Make sure anyone on the team can run `docker compose up` from a fresh clone and have a working application within a minute or two:
   - Document the setup steps in `docs/local-setup.md` (clone, copy `.env.example` to `.env`, run compose)
   - Confirm the database migrations or seed data run automatically on first start
   - Test this by having another team member (or the QA engineer) try the steps from scratch

3. **Add a CI smoke test** -- Update the GitHub Actions workflow to spin up the compose stack and verify the application responds. A simple `curl` against the health check endpoint is enough:

   ```yaml
   - name: Start stack
     run: docker compose up -d --wait
   - name: Smoke test
     run: curl --fail http://localhost/api/health
   ```

4. **Review container logs** -- Make sure each service writes structured logs that are readable with `docker compose logs <service>`. If the backend uses a logger, confirm the format is consistent.

## Verification

- [ ] Reverse proxy routing `/api/` to backend and `/` to frontend
- [ ] Another team member can start the full stack from scratch with `docker compose up`
- [ ] `docs/local-setup.md` written
- [ ] CI workflow runs a smoke test against the compose stack

---

Previous: [Phase 2 -- DevOps Engineer Tasks](../phase-2-sprint-1-build/devops-engineer.md) | Next: [Phase 4 -- DevOps Engineer Tasks](../phase-4-deploy-demo/devops-engineer.md)
