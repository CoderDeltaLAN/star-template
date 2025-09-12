# ⭐ Star Template — Always‑Green Starter for Node + Python

A lean, production‑grade template for **TypeScript libraries** and **Python packages** with a **strict green workflow**.  
It mirrors CI locally, enforces style/tests/typing, ships with **GitHub Actions** (Linux matrix) and **CodeQL**, and keeps histories clean and linear.  
Use it to bootstrap small libs or new repos that must **stay green**, integrate safely, and scale with confidence.

<div align="center">

[![Build](https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml)
[![CodeQL](https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml)
![Python 3.11|3.12](https://img.shields.io/badge/Python-3.11%20|%203.12-3776AB?logo=python)
![Node 20.x](https://img.shields.io/badge/Node-20.x-339933?logo=node.js)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

</div>

---

## 📸 Visual Overview

### CI pipeline (GitHub Actions)

> Real‑time status is in the badges above — the diagram shows what runs on each push/PR.

```mermaid
flowchart LR
  subgraph Node["Node (Linux)"]
    A1[Prettier check]
    A2[ESLint (no warnings)]
    A3[TypeScript --noEmit]
    A4[Jest tests]
  end

  subgraph Py311["Python (Linux, 3.11)"]
    B1[ruff]
    B2[black --check]
    B3[pytest -q]
    B4[mypy src]
    B5[smoke import]
  end

  subgraph Py312["Python (Linux, 3.12)"]
    C1[ruff]
    C2[black --check]
    C3[pytest -q]
    C4[mypy src]
    C5[smoke import]
  end

  subgraph Sec["Security"]
    D1[CodeQL analyze]
  end

  A1 --> A2 --> A3 --> A4
  B1 --> B2 --> B3 --> B4 --> B5
  C1 --> C2 --> C3 --> C4 --> C5
  A4 --> D1
  B5 --> D1
  C5 --> D1
```

### Repo layout

```text
.
├── lib/                 # TS build output
├── test/                # TS tests (Jest)
├── src/star_template/   # Python package
├── tests/               # Python tests (pytest)
└── .github/workflows/   # build.yml, codeql.yml
```

---

## 🚀 Quick Start

### Node / TypeScript

```bash
npm ci
npx prettier -c .
npx eslint . --max-warnings=0
[ -f tsconfig.json ] && npx tsc -p tsconfig.json --noEmit || true
npm test --silent
```

Pack + smoke locally:

```bash
npm pack
mkdir -p /tmp/star-template-npm-smoke && cd /tmp/star-template-npm-smoke
npm init -y >/dev/null
npm install "/absolute/path/to/star-template-ts-<version>.tgz" --silent
node -e "require('star-template-ts'); console.log('node import OK')"
```

### Python

```bash
poetry install --no-interaction
poetry run ruff check .
poetry run black --check .
PYTHONPATH=src poetry run pytest -q
poetry run mypy src
poetry build
python - <<'PY'
import importlib; m = importlib.import_module("star_template")
print("python import OK:", getattr(m, "__version__", "unknown"))
PY
```

---

## 🧪 Local Developer Workflow (mirrors CI)

```bash
# Node
npx prettier -c .
npx eslint . --max-warnings=0
[ -f tsconfig.json ] && npx tsc --noEmit || true
npm test --silent

# Python
poetry run ruff check .
poetry run black --check .
PYTHONPATH=src poetry run pytest -q
poetry run mypy src
```

---

## 🔧 CI (GitHub Actions)

- Linux matrix for Node and Python (3.11, 3.12).
- Jobs match local gates to avoid “works‑on‑my‑machine”.
- **Logs per job** are uploaded as artifacts for troubleshooting.
- **CodeQL** enabled for static analysis.

Example Python job steps:

```yaml
- run: python -m pip install -U pip
- run: pip install ruff black pytest mypy
- run: ruff check .
- run: black --check .
- run: pytest -q
- run: mypy src
```

---

## 🗺️ When to Use This Template

- You need a **minimal yet strict** starter for Node + Python libs.
- **Always‑green** policy: PRs blocked unless checks pass.
- You value **linear history** (squash merge) and reproducible local gates.

---

## 🧩 Customization

- Use only one stack? Remove the other stack’s files and its CI job.
- Add Windows/macOS runners by extending `build.yml`.
- Lower strictness (e.g., Python coverage) by adjusting `pytest.ini`.

---

## 🛡️ Security

- Private disclosures via GitHub Security advisories.
- **CodeQL** runs on PRs and pushes to `main`.

---

## 🙌 Contributing

- **Small, atomic PRs** with Conventional Commits.
- Keep **local gates** green before pushing.
- Enable **auto‑merge** once checks pass.

---

## 📈 SEO Keywords

always green ci template, always‑green workflow, typescript library starter, node eslint prettier jest template,  
python package template poetry, ruff black pytest mypy starter, github actions matrix ci, codeql security scan template,  
branch protection required checks, dual stack repo template, clean history conventional commits, npm pack smoke test,  
poetry build smoke test, linux matrix ci, job log artifacts, reproducible dev workflow

---

## 💚 Donations & Sponsorship

Open-source takes time. If this template saves you hours, consider supporting continued maintenance and polish. Thank you!

[![Donate](https://img.shields.io/badge/Donate-PayPal-0070ba?logo=paypal&logoColor=white)](https://www.paypal.com/donate/?hosted_button_id=YVENCBNCZWVPW)

## 👤 Author

**CoderDeltaLAN (Yosvel)**  
Email: `coderdeltalan.cargo784@8alias.com`  
GitHub: https://github.com/CoderDeltaLAN

## 📄 License

Released under the **MIT License**. See [LICENSE](LICENSE).
