# star-template

> **Always-Green starter** for **TypeScript libraries** and **Python packages**. It mirrors CI locally, enforces fast quality gates, and ships with a robust GitHub Actions matrix (Node + Python) plus **CodeQL**. Use it to start projects that stay green, publish confidently, and keep histories clean.

[![Build](https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml)
[![CodeQL](https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Always-Green](https://img.shields.io/badge/always--green-CI-2ea44f?logo=githubactions)

---

## What is this?

`star-template` is a **production-grade template** that gives you two batteries-included stacks:

- **TypeScript (Node)** — TS5, ESLint 9 (flat), Prettier 3, Jest, optional type-check via `tsc --noEmit`.
- **Python** — Poetry, ruff, black, pytest, mypy, and **100% coverage gate** (configurable).

It is designed for teams that want:

- **Identical local and CI gates** (no “works on my machine”).
- **Fast feedback**: linters first, tests next, type checkers last.
- **Green-only merges** with **branch protection** compatibility.
- **Security** by default via **GitHub CodeQL**.
- **Readable logs** per job, uploaded as CI artifacts.

---

## When to use it

- You’re starting a new lib (TS or Python) and want **sane defaults**.
- You require **consistent quality gates** across contributors and CI.
- You care about **clean commit history** and **reliable PR signals**.
- You want **both ecosystems** in one repo (dual-stack), or just one—keep what you need.

---

## Highlights

- ✅ **Always-Green**: local preflight equals CI checks.
- 🧪 **Tests**: Jest for TS, pytest for Python; coverage gate on Python by default.
- 🧹 **Style & Lint**: Prettier 3, ESLint 9, ruff, black.
- 🔎 **Types**: `tsc --noEmit` and **mypy** on `src`.
- 🔐 **Security**: **CodeQL** workflow wired.
- 🧰 **Artifacts**: per-job logs (Node & Python) uploaded automatically.
- 🧩 **Branch-protection friendly**: job names are stable and intended as required checks.
- 🧪 **Smoke tests** for importability (Node & Python).

---

## Quick Start

### TypeScript / Node

```bash
npm ci
npx prettier -c .
npx eslint . --max-warnings=0
[ -f tsconfig.json ] && npx tsc -p tsconfig.json --noEmit || true
npm test --silent
```

Pack & smoke locally:

```bash
npm pack
# smoke install from a temp folder
TMP=/tmp/star-template-npm-smoke && rm -rf "$TMP" && mkdir -p "$TMP" && cd "$TMP"
npm init -y >/dev/null
npm install "/absolute/path/to/star-template-ts-<version>.tgz" --silent
node -e "require('star-template-ts'); console.log('node import OK')"
```

### Python

```bash
poetry install --no-interaction
poetry run ruff check .
poetry run black --check .
PYTHONPATH=src poetry run pytest -q --disable-warnings
poetry run mypy src
```

Smoke import & build:

```bash
poetry run python -c "import star_template as m; print('python import OK', getattr(m,'__version__','?'))"
poetry build
```

---

## Local Workflow (same as CI)

```bash
# Node
npx prettier -c .
npx eslint . --max-warnings=0
[ -f tsconfig.json ] && npx tsc -p tsconfig.json --noEmit || true
npm test --silent

# Python
poetry run ruff check .
poetry run black --check .
PYTHONPATH=src poetry run pytest -q --disable-warnings
poetry run mypy src
```

> If it’s green locally, it’s green in CI.

---

## CI (GitHub Actions)

- **Workflow**: `.github/workflows/build.yml` (Linux matrix).
- **Jobs**:
  - **Node (Linux)** — `npm ci` ➜ Prettier ➜ ESLint ➜ (optional) `tsc --noEmit` ➜ Jest.
  - **Python (Linux, 3.11/3.12)** — ruff ➜ black ➜ pytest (100% gate) ➜ mypy ➜ smoke import.
- **Artifacts**: Each job uploads logs under `python-3.xx-logs/*` and `node-logs/*`.

Status badges (main branch):

- Build: \
  `https://github.com/CoderDeltaLAN/star-template/actions/workflows/build.yml/badge.svg?branch=main`
- CodeQL: \
  `https://github.com/CoderDeltaLAN/star-template/actions/workflows/codeql.yml/badge.svg?branch=main`

### Required checks (branch protection)

Recommended required checks for `main`:

- `build/Node (Linux)`
- `build/Python (Linux, 3.11)`
- `build/Python (Linux, 3.12)`
- `CodeQL/CodeQL Analyze (push)` and/or `(pull_request)`

> Job names are intentionally stable so you can copy them into protection rules.

### Fetch CI logs locally (GitHub CLI)

```bash
# last run of build on main
RID="$(gh run list --workflow build.yml --branch main --limit 1 --json databaseId --jq '.[0].databaseId')"
mkdir -p _ci_logs/"$RID"
gh run view "$RID" --log > _ci_logs/run_"$RID".log
gh run download "$RID" --dir _ci_logs/"$RID"
```

---

## Project Structure

```
.
├── lib/                 # TS build output
├── test/                # TS tests (Jest)
├── src/star_template/   # Python package
├── tests/               # Python tests (pytest)
└── .github/workflows/   # build.yml, codeql.yml
```

---

## Releasing (manual, example)

### Node (npm)

```bash
npm version <patch|minor|major>
npm publish --access public
```

### Python (PyPI)

```bash
poetry version <patch|minor|major>
poetry build
poetry publish
```

> Automating releases is intentionally left out—add your favorite release pipeline when ready.

---

## Troubleshooting

- **Prettier fails on CI artifacts** → `_ci_logs/**` is ignored via `.prettierignore`.
- **Matrix logs** → artifacts are grouped per job, e.g. `python-3.12-logs/pytest.log`.
- **Rerun only failed** → `gh run rerun <run-id> --failed`.
- **Clean orphaned runs** (stale branches):
  ```bash
  REPO="CoderDeltaLAN/star-template"
  ACTIVE="$(gh api "repos/$REPO/branches?per_page=100" --paginate --jq '.[].name' | sort -u)"
  gh api "repos/$REPO/actions/runs?per_page=100" --paginate \
    --jq '.workflow_runs[] | [.id,.head_branch,.conclusion] | @tsv' \
  | while IFS=$'\t' read -r ID BR C; do
      echo "$ACTIVE" | grep -qx "$BR" || gh api -X DELETE "repos/$REPO/actions/runs/$ID" >/dev/null 2>&1 || true
    done
  ```

---

## Contributing

- **Small, atomic PRs** with Conventional Commits.
- Keep **local gates** green before pushing.
- Enable **auto-merge** once checks pass.

---

## Security

- Use **GitHub Security** advisory process for private disclosures.
- **CodeQL** runs on PRs and/or pushes to `main`.

---

## FAQ

**Q: Can I use only one stack?**  
Yes. Delete the other stack’s files and remove its CI job.

**Q: Windows/macOS runners?**  
Add extra jobs to `build.yml` if you need broader OS coverage.

**Q: Why 100% Python coverage by default?**  
To set a high bar for small libs. Adjust in `pytest.ini` if needed.

---

## 📈 SEO Keywords

always green ci template, typescript library starter, node eslint prettier jest template,
python package template poetry, ruff black pytest mypy starter, github actions matrix ci,
codeql security scan template, branch protection required checks, dual stack repo template,
clean history conventional commits, npm pack smoke test, poetry build smoke test

---

## Author

**CoderDeltaLAN (Yosvel)**  
Email: `coderdeltalan.cargo784@8alias.com`  
GitHub: https://github.com/CoderDeltaLAN

## License

Released under the **MIT License**. See [LICENSE](LICENSE).
