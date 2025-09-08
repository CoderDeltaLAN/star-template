#!/usr/bin/env bash
ORG="$1"; NAME="$2"; PITCH="$3"
if [ -z "$ORG" ] || [ -z "$NAME" ] || [ -z "$PITCH" ]; then
  echo "usage: ./new-repo.sh <Org> <Name> \"One-line pitch\"" >&2
  exit 1
fi
ok=1
if [ -f "pyproject.toml" ]; then
  poetry install --no-interaction || ok=0
  poetry run ruff check . --fix || ok=0
  poetry run ruff format . || ok=0
  poetry run black . || ok=0
  PYTHONPATH=src poetry run pytest -q || ok=0
fi
if [ -f "package.json" ]; then
  npm ci || ok=0
  npm run lint || ok=0
  npm run format || ok=0
  npm run build || ok=0
  npm test -- --ci || ok=0
fi
if [ "$ok" != "1" ]; then
  echo "[gate] local checks FAILED. aborting." >&2
  exit 2
fi
echo "[ok] local green. Ready for manual push/PR when you decide."
