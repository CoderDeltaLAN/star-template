# ⭐ Star Template — Always-Green Starter for Node + Python

A lean, production-grade template for **TypeScript libraries** and **Python packages** with a **strict green workflow**.  
It mirrors CI locally, enforces style/tests/typing, ships with **GitHub Actions** (Linux matrix) and **CodeQL**, and keeps histories clean and linear.  
Use it to bootstrap small libs or new repos that must **stay green**, integrate safely, and scale with confidence.

<div align="center">

[![Build](https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml)
[![CodeQL](https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml)
[![Release](https://img.shields.io/github/v/release/CoderDeltaLAN/star-template?display_name=tag)](https://github.com/CoderDeltaLAN/star-template/releases)
![Python 3.11|3.12](https://img.shields.io/badge/Python-3.11%20|%203.12-3776AB?logo=python)
![Node 20.x](https://img.shields.io/badge/Node-20.x-339933?logo=node.js)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Donate](https://img.shields.io/badge/Donate-PayPal-0070ba?logo=paypal&logoColor=white)](https://www.paypal.com/donate/?hosted_button_id=YVENCBNCZWVPW)

</div>

---

## Repo layout

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
- Jobs match local gates to avoid “works-on-my-machine”.
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
- **Always-green** policy: PRs blocked unless checks pass.
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
- Enable **auto-merge** once checks pass.

---

## 📈 SEO Keywords

always green ci template, always-green workflow, typescript library starter, node eslint prettier jest template,  
python package template poetry, ruff black pytest mypy starter, github actions matrix ci, codeql security scan template,  
branch protection required checks, dual stack repo template, clean history conventional commits, npm pack smoke test,  
poetry build smoke test, linux matrix ci, job log artifacts, reproducible dev workflow

---

## 👤 Author

**CoderDeltaLAN (Yosvel)**
Email: `coderdeltalan.cargo784@8alias.com`
GitHub: https://github.com/CoderDeltaLAN

---

## 💚 Donations & Sponsorship

Open-source takes time. If this template saves you hours, consider supporting continued maintenance and polish. Thank you!
[![Donate](https://img.shields.io/badge/Donate-PayPal-0070ba?logo=paypal&logoColor=white)](https://www.paypal.com/donate/?hosted_button_id=YVENCBNCZWVPW)

---

## 📄 License

Released under the **Apache License 2.0**. See [LICENSE](LICENSE).
