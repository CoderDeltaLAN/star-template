# star-template

A lean, production-grade starter for **TypeScript libraries** and **Python packages** with an **Always-Green** workflow: reproducible local gates, GitHub Actions CI (Linux matrix), and **CodeQL**. Designed to keep `main` green and histories clean.

[![Build](https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml)
[![CodeQL](https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## Why

Green builds are non‑negotiable. This repo mirrors CI locally and gates PRs with the same checks. You get reliable signals, linear history, and painless reviews.

## What It Includes

- **Package layout for two stacks:**
  - **TypeScript (Node):** TypeScript 5, ESLint 9 (flat config), Prettier 3, Jest (ts-jest).
  - **Python:** Poetry, ruff, black, pytest, mypy, **100% coverage required** by default.
- **GitHub Actions CI:** Linux matrix for Node/Python; Windows can be added as optional.
- **Security:** **CodeQL** scanning enabled.
- **Branch‑protection friendly:** Job names designed as required checks.

## Quick Start

### Node / TypeScript

```bash
npm ci
npm run -s build
npm test --silent
```

Pack + smoke locally:

```bash
# from repo root
npm pack
# smoke in a clean dir
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
poetry run mypy .
poetry build
python - <<'PY'
import importlib; m = importlib.import_module("star_template")
print("python import OK:", getattr(m, "__version__", "unknown"))
PY
```

## Local Developer Workflow

Run the same gates you’ll see in CI.

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
poetry run mypy .
```

## CI (GitHub Actions)

- Linux matrix for Python and Node.
- Jobs match local gates to avoid “works‑on‑my‑machine”.
- **CodeQL** enabled for code scanning.

Example Python job steps:

```yaml
- run: python -m pip install -U pip
- run: pip install ruff black pytest mypy
- run: ruff check .
- run: black --check .
- run: pytest -q
- run: mypy .
```

## Project Structure

```
.
├── lib/                 # TS build output
├── test/                # TS tests (Jest)
├── src/star_template/   # Python package
├── tests/               # Python tests (pytest)
└── .github/workflows/   # build.yml, codeql.yml
```

## Security

Report vulnerabilities privately. **CodeQL** runs in CI for static analysis.

## Contributing

Atomic PRs, Conventional Commits, and draft PRs until green. Keep local gates passing before any push.

## 🔍 SEO Keywords

always green ci, typescript library template, node eslint prettier jest, python package template,
ruff black pytest mypy, github actions python, github actions matrix, codeql security scan,
branch protection, required status checks, clean code workflow, oss starter, npm pack smoke,
poetry build smoke

## 💚 Donations & Sponsorship

Open‑source takes time. If this template saves you hours, consider supporting continued maintenance and polish. Thank you!

## 👤 Author

**CoderDeltaLAN (Yosvel)**  
Email: `coderdeltalan.cargo784@8alias.com`  
GitHub: https://github.com/CoderDeltaLAN

## 📄 License

Released under the **MIT License**. See the bundled `LICENSE` file for details.
