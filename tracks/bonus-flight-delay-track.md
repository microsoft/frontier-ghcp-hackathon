# Bonus Track: Full-Stack Flight Delay Predictor

**Duration:** 8-12 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Full-stack application development -- data science, API engineering, and frontend -- with GitHub Copilot

## Who Is This For

- Full-stack developers looking for a deep, cross-domain challenge
- Teams that finished their primary track early
- Experienced engineers who want to push Copilot's capabilities across multiple domains
- Anyone who wants to combine ML, API, and UI skills in a single project

## Prerequisites

- Python programming experience
- Basic understanding of machine learning concepts (classification, train/test split)
- Familiarity with REST APIs (Flask, FastAPI, or Express.js)
- Frontend development basics (HTML/CSS/JS or a framework like React, Svelte, Vue)
- Comfort working in Jupyter Notebooks

## Technology Stack

- **Python 3.11+** -- data analysis and API
- **Jupyter Notebooks** -- data exploration and model building
- pandas, numpy, scikit-learn, matplotlib, seaborn -- data science
- **Flask or FastAPI** -- backend API serving the model and airport data
- **TypeScript / JavaScript** -- frontend application
- Framework of your choice (React, Svelte, Vue, or vanilla)
- **Vite** -- frontend build tooling (provided)

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

**What to include:**

- Python version, key data science libraries (pandas, scikit-learn)
- Backend framework choice (Flask or FastAPI) and API design conventions
- Frontend framework choice and component patterns
- Code quality standards (PEP 8 for Python, ESLint for JS/TS)
- Testing expectations
- The project's overall goal: flight delay prediction from FAA data

### Suggested Agents

**Agents to consider creating:**

- **Data Scientist Agent** -- Expert in EDA, feature engineering, and model training
- **API Engineer Agent** -- Focused on REST API design, Flask/FastAPI, and data serialization
- **Frontend Developer Agent** -- Specialized in building UIs with your chosen framework
- **Full-Stack Integrator Agent** -- Understands the entire pipeline from model to UI

### Open the Challenge

Navigate to `challenges/bonus-2-flight-delay/`. A dedicated devcontainer is provided at `.devcontainer/bonus-2-flight-delay/` with Python 3.11, Jupyter, scikit-learn, Flask, FastAPI, and Node.js LTS.

---

## Phases

This challenge is broken into four phases. Each phase builds on the previous one.

| Phase | Name | Duration | Focus |
|-------|------|----------|-------|
| 1 | [Data Exploration and Model Building](bonus-flight-delay-track/phase-1-data-exploration.md) | 3-4 hours | Jupyter Notebook, data science, machine learning |
| 2 | [Build the Prediction API](bonus-flight-delay-track/phase-2-prediction-api.md) | 2-3 hours | REST API, Flask or FastAPI, model serving |
| 3 | [Build the Frontend](bonus-flight-delay-track/phase-3-frontend.md) | 2-3 hours | Frontend, UI/UX, API integration |
| 4 | [Polish and Advanced Features](bonus-flight-delay-track/phase-4-polish.md) | 1-2 hours | Production readiness, bonus challenges |

## Tips for Using Copilot on This Track

**Data science -- start each cell with a descriptive comment:**

```python
# Load the flights dataset from data/flights.csv
# Display shape, first 5 rows, and count of null values per column
```

**API development -- start with a blueprint:**

```python
# Flask API for flight delay prediction
# Endpoints:
# - GET /predict?day_of_week=<int>&airport_id=<int> → returns delay probability
# - GET /airports → returns list of airports sorted by name
# Load model from model.pkl, airports from airports.csv
```

**Frontend -- describe your UI:**

```typescript
// Create a form with:
// - A dropdown populated from GET /airports
// - A day-of-week selector (Monday through Sunday)
// - A submit button that calls GET /predict and displays the result
// - A results section showing delay probability as a percentage
```

**Debugging across the stack:**

- CORS errors? Ask Copilot: *"How do I enable CORS in Flask?"*
- Model not loading? Use `/fix` on the error traceback.
- Frontend not rendering? Ask Copilot to review your component structure.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
