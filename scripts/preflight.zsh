#!/usr/bin/env zsh
REPO="${REPO:-$PWD}"
PERSIST="/tmp/preflight-last"; rm -rf "$PERSIST"; mkdir -p "$PERSIST"
TMP="$(mktemp -d -t preflight-XXXX)" || exit 1
git -C "$REPO" archive --format=tar HEAD | tar -x -C "$TMP" || exit 1
cd "$TMP" || exit 1

LOG="$PERSIST/run.log"; : > "$LOG"; FAILS=""
run(){ print -r -- "\n$ $*" | tee -a "$LOG"; eval "$*" >>"$LOG" 2>&1 || FAILS="$FAILS; $*"; }

# Node
run 'NPM_CONFIG_LOGLEVEL=error NPM_CONFIG_AUDIT=false NPM_CONFIG_FUND=false npm ci --silent --no-audit --fund=false'
run 'npx prettier -c .'
run 'npx eslint . --max-warnings=0'
[[ -f tsconfig.json ]] && run 'npx tsc -p tsconfig.json --noEmit'
run 'npm test --silent'
rm -f -- *.tgz(N)   # <- zsh: evita "no matches found"
PKG="$(npm pack --silent)"; print -r -- "PKG=$PKG" | tee -a "$LOG"
tar -tf "$PKG" | sed 's/^[^/]*\///' | sort > "$PERSIST/tar.txt"

# Python
run 'python -m pip install --upgrade pip'
run 'pip install poetry'
run 'poetry install --no-interaction'
run 'poetry run ruff check .'
run 'poetry run black --check .'
run 'PYTHONPATH=src poetry run pytest -q'
run 'poetry run python -c "import star_template; print(\"py-smoke-ok\")"'

# Validación tgz allowlist
EXTRA="$(grep -Ev '^(lib/src/|LICENSE$|README.md$|SECURITY.md$|package.json$)' "$PERSIST/tar.txt" || true)"
[[ -n "$EXTRA" ]] && { print -r -- "$EXTRA" > "$PERSIST/tar.extra"; FAILS="$FAILS; tgz-extras"; }

cd "$REPO"; rm -rf "$TMP"
[[ -z "$FAILS" ]] && { echo "✅ PRE-FLIGHT VERDE | LOG=$LOG"; exit 0; } || { echo "❌ PRE-FLIGHT ROJO:$FAILS | LOG=$LOG"; exit 1; }
