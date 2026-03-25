# QA Tester Track

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Test automation, quality assurance, and testing best practices with GitHub Copilot

## Who Is This For

- QA Engineers & SDETs
- Test Automation Engineers
- Manual testers transitioning to automation

## Prerequisites

<!-- TODO: fill in prerequisites (e.g., deploying the demo application) -->

## Technology Stack

- **Application**: .NET 9.0 / ASP.NET Core + .NET Aspire (eShop)
- **Language**: C# (application and unit tests), TypeScript (E2E tests)
- **Unit Testing**: xUnit
- **E2E Testing**: Playwright (TypeScript)
- **AI Integration**: Playwright MCP Server
- **Environment**: Docker & DevContainers

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

**What to include:**

- Testing frameworks in use (Jest, Pytest, Playwright, etc.)
- Testing standards (AAA pattern, naming conventions)
- Coverage goals and quality metrics
- E2E testing approach and patterns

### Suggested Agents

**Agents to consider creating:**

- **Test Architect Agent** -- Expert in test strategy, coverage, and automation frameworks
- **Playwright Expert Agent** -- Specialized in browser automation and E2E testing
- **Performance Tester Agent** -- Focused on load testing and performance analysis

### Open the Challenge

Navigate to `challenges/challenge-5-qa/`. Unlike other challenges, you will test an existing application (eShop) rather than building one.

#### Setup: Target Application

You will be testing **[eShop](https://github.com/dotnet/eShop)**, a .NET Aspire reference application with a microservices architecture.

> ⚠️ **Setup note**: eShop uses .NET Aspire and Docker. The initial setup takes a few minutes as it pulls container images and starts multiple services. Be patient during first launch.

1. **Clone the Repository**:

    ```bash
    git clone https://github.com/dotnet/eShop.git app
    cd app && git checkout 5624ad564d1602a927879df32a79b94522eb6101
    ```

2. **Clean Up Existing Tests**:

    ```bash
    rm -rf app/tests app/e2e
    ```

3. **Remove Test Projects from Solution**:
    Open `app/eShop.slnx` and remove the test projects from the solution file.

4. **Remove from solution filter**:
    Also delete test project references from `app/eShop.slnf`.

5. **Verify Application Runs**:

    ```bash
    cd app
    dotnet restore eShop.Web.slnf
    dotnet dev-certs https --trust
    dotnet run --project src/eShop.AppHost/eShop.AppHost.csproj
    ```

    Open the Aspire dashboard URL from terminal output. Update `baseURL` in `playwright.config.ts` to match your running eShop webapp URL.

6. **Install Playwright**:

    ```bash
    cd challenges/challenge-5-qa
    npm install
    npx playwright install
    ```

---

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [Setup and Debug Starter Tests](qa-tester-track/stage-1-setup-debug.md) | ⭐⭐ | 60-75 min | Fix 3 bugs in LoginPage, adapt selectors, add test cases |
| 2 | [Page Object Expansion and Shopping Flow](qa-tester-track/stage-2-page-objects.md) | ⭐⭐ | 60-90 min | CatalogPage, BasketPage, full E2E shopping test, fixtures |
| 3 | [Cross-Browser, Mobile, and Resilience](qa-tester-track/stage-3-cross-browser.md) | ⭐⭐⭐ | 60-90 min | Tests pass on 3 browsers + mobile, network throttling, visual comparison |
| 4 | [AI-Driven Testing and Hybrid Approach](qa-tester-track/stage-4-ai-driven.md) | ⭐⭐⭐ | 60-90 min | MCP-generated tests, API+UI hybrid tests, data consistency verification |
| 5 | [Quality Gates, Reporting, and CI](qa-tester-track/stage-5-quality-gates.md) | ⭐⭐⭐ | 60-90 min | GitHub Actions CI, custom markdown reporter, flakiness analysis, test strategy |

Copilot generates test boilerplate efficiently, but Stage 1 starts with debugging intentionally broken code, and later stages require cross-browser troubleshooting and test strategy decisions.

> **Short on time?** Skip mobile and visual comparison in Stage 3, do only MCP exploration in Stage 4, and focus on the CI workflow only in Stage 5.

## Tips for Using Copilot on This Track

- Keep the file under test open when generating test cases -- Copilot reads it as context.
- Describe the user flow you want to test before asking for Playwright code. A sentence of intent beats a blank prompt.
- If the MCP tool fails, check the Output panel in VS Code under "GitHub Copilot MCP" for logs.
- Make sure the application port is forwarded in the DevContainer so the headless browser can reach it.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
