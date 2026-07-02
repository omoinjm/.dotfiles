#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FISH_DIR="$ROOT/src/config/fish"
FAILED=0

pass() { echo "PASS: $1"; }
fail() { echo "FAIL: $1"; FAILED=1; }

echo "==> Checking fish syntax"
if command -v fish >/dev/null 2>&1; then
  while IFS= read -r -d '' file; do
    if fish -n "$file" 2>/dev/null; then
      pass "fish syntax: ${file#$ROOT/}"
    else
      fail "fish syntax: ${file#$ROOT/}"
      fish -n "$file" || true
    fi
  done < <(find "$FISH_DIR" -name '*.fish' ! -name '*.example' -print0)
else
  echo "SKIP: fish not installed"
fi

echo "==> Checking for committed secrets"
SECRET_PATTERN='(GPG_PASSWORD\s+[^{]|BEGIN PGP PRIVATE KEY BLOCK|discord\.com/api/webhooks/[0-9]+/[A-Za-z0-9_-]+|Bot [A-Za-z0-9._-]{20,})'
if rg -n "$SECRET_PATTERN" "$ROOT/src" -g '*.fish' -g '*.ps1' -g '*.pgp' -g '!*.example' >/dev/null 2>&1; then
  fail "possible secrets found in tracked source files"
  rg -n "$SECRET_PATTERN" "$ROOT/src" -g '*.fish' -g '*.ps1' -g '*.pgp' -g '!*.example' || true
else
  pass "no obvious secrets in source files"
fi

echo "==> Checking for hardcoded home paths"
if rg -n '/home/omoinjm|"/\.local/' "$ROOT/src/config/fish" -g '*.fish' -g '!*.example' >/dev/null 2>&1; then
  fail "hardcoded or broken home paths found"
  rg -n '/home/omoinjm|"/\.local/' "$ROOT/src/config/fish" -g '*.fish' -g '!*.example' || true
else
  pass "no hardcoded home paths in fish config"
fi

echo "==> Checking path configuration"
if rg -Fxq 'set -gx PNPM_HOME "$HOME/.local/share/pnpm"' "$FISH_DIR/conf.d/node.fish"; then
  pass "PNPM_HOME uses HOME"
else
  fail "PNPM_HOME is not set to \$HOME/.local/share/pnpm"
fi

if rg -Fxq 'set -gx GOPATH "$HOME/go"' "$FISH_DIR/conf.d/go.fish"; then
  pass "GOPATH uses HOME"
else
  fail "GOPATH is not set to \$HOME/go"
fi

echo "==> Checking local secret examples exist"
for example in secrets.fish.example ssh.fish.example; do
  if [[ -f "$FISH_DIR/conf.d/$example" ]]; then
    pass "example present: conf.d/$example"
  else
    fail "missing example: conf.d/$example"
  fi
done

echo "==> Checking gitignore covers local secrets"
for pattern in 'conf.d/secrets.fish' 'conf.d/ssh.fish' '.last_cleanup_date' 'private.pgp'; do
  if rg -Fq "$pattern" "$ROOT/.gitignore" "$FISH_DIR/.gitignore" 2>/dev/null; then
    pass "gitignore covers $pattern"
  else
    fail "gitignore missing pattern: $pattern"
  fi
done

if [[ "$FAILED" -eq 0 ]]; then
  echo "All tests passed."
  exit 0
fi

echo "Some tests failed."
exit 1
