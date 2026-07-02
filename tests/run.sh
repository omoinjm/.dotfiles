#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FISH_DIR="$ROOT/home/.config/fish"
FAILED=0

pass() { echo "PASS: $1"; }
fail() { echo "FAIL: $1"; FAILED=1; }

FORBIDDEN_TRACKED=(
  home/.config/fish/conf.d/secrets.fish
  home/.config/fish/conf.d/ssh.fish
  home/.config/fish/config-local.fish
  home/.config/fish/fish_variables
  home/.config/fish/.last_cleanup_date
  secrets/password-store/exported-keys/private.pgp
  secrets/password-store/exported-keys/public.pgp
)

SECRET_PATTERN='(GPG_PASSWORD[[:space:]]+[^{]|BEGIN PGP PRIVATE KEY BLOCK|discord\.com/api/webhooks/[0-9]+/[A-Za-z0-9_-]+|Bot [A-Za-z0-9._-]{20,})'
HOME_PATH_PATTERN='/home/omoinjm|"/\.local/'

echo "==> Checking repository layout"
for path in \
  home/.config/fish \
  home/.config/nvim \
  platform/linux/shell/bash \
  platform/windows/powershell \
  secrets/fish \
  install/link.sh; do
  if [[ -e "$ROOT/$path" ]]; then
    pass "layout: $path"
  else
    fail "missing layout path: $path"
  fi
done

if [[ -d "$ROOT/src" ]]; then
  fail "legacy src/ directory still exists"
else
  pass "legacy src/ removed"
fi

echo "==> Checking secret paths are not tracked"
for path in "${FORBIDDEN_TRACKED[@]}"; do
  if git -C "$ROOT" ls-files --error-unmatch "$path" >/dev/null 2>&1; then
    fail "tracked secret or local-only path: $path"
  else
    pass "not tracked: $path"
  fi
done

echo "==> Checking tracked files for secrets"
tracked_secret_hits=0
while IFS= read -r -d '' file; do
  case "$file" in
    *.example) continue ;;
    tests/*|scripts/*|SECURITY.md) continue ;;
  esac
  if rg -n "$SECRET_PATTERN" "$ROOT/$file" >/dev/null 2>&1; then
    fail "possible secret in tracked file: $file"
    rg -n "$SECRET_PATTERN" "$ROOT/$file" || true
    tracked_secret_hits=1
  fi
done < <(git -C "$ROOT" ls-files -z)

if [[ "$tracked_secret_hits" -eq 0 ]]; then
  pass "no obvious secrets in tracked files"
fi

echo "==> Checking fish syntax"
if command -v fish >/dev/null 2>&1; then
  while IFS= read -r -d '' file; do
    if fish -n "$file" 2>/dev/null; then
      pass "fish syntax: ${file#$ROOT/}"
    else
      fail "fish syntax: ${file#$ROOT/}"
      fish -n "$file" || true
    fi
  done < <(find "$FISH_DIR" -name '*.fish' -print0)
else
  echo "SKIP: fish not installed"
fi

echo "==> Checking for hardcoded home paths in tracked fish config"
tracked_fish_hits=0
while IFS= read -r -d '' file; do
  if rg -n "$HOME_PATH_PATTERN" "$ROOT/$file" >/dev/null 2>&1; then
    fail "hardcoded or broken home path in tracked file: $file"
    rg -n "$HOME_PATH_PATTERN" "$ROOT/$file" || true
    tracked_fish_hits=1
  fi
done < <(git -C "$ROOT" ls-files -z 'home/.config/fish/*.fish' 'home/.config/fish/**/*.fish')

if [[ "$tracked_fish_hits" -eq 0 ]]; then
  pass "no hardcoded home paths in tracked fish config"
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

echo "==> Checking secret examples exist"
for example in \
  secrets/fish/secrets.fish.example \
  secrets/fish/ssh.fish.example \
  secrets/discord/env.example \
  secrets/password-store/exported-keys/private.pgp.example \
  secrets/password-store/exported-keys/public.pgp.example; do
  if [[ -f "$ROOT/$example" ]]; then
    pass "example present: $example"
  else
    fail "missing example: $example"
  fi
done

echo "==> Checking gitignore covers local secrets"
for pattern in \
  'conf.d/secrets.fish' \
  'conf.d/ssh.fish' \
  '.last_cleanup_date' \
  'private.pgp' \
  'public.pgp'; do
  if rg -Fq "$pattern" "$ROOT/.gitignore" "$FISH_DIR/.gitignore" 2>/dev/null; then
    pass "gitignore covers $pattern"
  else
    fail "gitignore missing pattern: $pattern"
  fi
done

echo "==> Checking install scripts are executable"
for script in install/link.sh install/install.sh scripts/purge-secrets-from-history.sh; do
  if [[ -x "$ROOT/$script" ]]; then
    pass "executable: $script"
  else
    fail "not executable: $script"
  fi
done

if [[ "$FAILED" -eq 0 ]]; then
  echo "All tests passed."
  exit 0
fi

echo "Some tests failed."
exit 1
