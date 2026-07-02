#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<'EOF'
Remove secret-bearing paths from the entire git history.

Requires: git-filter-repo

  Debian/Ubuntu/WSL:  sudo apt install git-filter-repo
  Other (pipx):       pipx install git-filter-repo

This rewrites history. Coordinate with anyone using the repo, then force-push:

  git push --force-with-lease origin <branch>

Paths removed from all commits:
  - home/.config/fish/conf.d/secrets.fish
  - home/.config/fish/conf.d/ssh.fish
  - secrets/password-store/exported-keys/private.pgp
  - secrets/password-store/exported-keys/public.pgp
  - src/config/fish/fish_variables

After running, rotate any credentials that were ever committed (GPG passphrase,
PGP keys, webhooks, tokens). See SECURITY.md.

Usage:
  scripts/purge-secrets-from-history.sh --dry-run
  scripts/purge-secrets-from-history.sh --execute
EOF
}

find_git_filter_repo() {
  local candidate
  if command -v git-filter-repo >/dev/null 2>&1; then
    command -v git-filter-repo
    return 0
  fi
  for candidate in "$HOME/.local/bin/git-filter-repo"; do
    if [[ -x "$candidate" ]]; then
      echo "$candidate"
      return 0
    fi
  done
  return 1
}

if ! GIT_FILTER_REPO="$(find_git_filter_repo)"; then
  cat >&2 <<'EOF'
error: git-filter-repo is not installed.

On Debian/Ubuntu/WSL (recommended):
  sudo apt install git-filter-repo

Elsewhere with pipx:
  pipx install git-filter-repo

Avoid: pip install --user (PEP 668 may block system Python on recent distros).
EOF
  exit 1
fi

mode="${1:-}"
if [[ "$mode" != "--dry-run" && "$mode" != "--execute" ]]; then
  usage
  exit 1
fi

paths=(
  home/.config/fish/conf.d/secrets.fish
  home/.config/fish/conf.d/ssh.fish
  secrets/password-store/exported-keys/private.pgp
  secrets/password-store/exported-keys/public.pgp
  src/config/fish/fish_variables
)

args=(--force)
for path in "${paths[@]}"; do
  args+=(--path "$path" --invert-paths)
done

SECRET_CONTENT_PATTERN='(GPG_PASSWORD[[:space:]]+[^{]|BEGIN PGP PRIVATE KEY BLOCK|discord\.com/api/webhooks/[0-9]+/[A-Za-z0-9_-]+|Bot [A-Za-z0-9._-]{20,})'

report_history_paths() {
  local path found=0
  echo "Paths present in git history (will be removed):"
  for path in "${paths[@]}"; do
    if git -C "$ROOT" log --all --oneline -- "$path" | head -1 | grep -q .; then
      found=1
      local count
      count="$(git -C "$ROOT" rev-list --all --count -- "$path")"
      echo "  - $path ($count commit(s))"
    else
      echo "  - $path (not in history)"
    fi
  done
  if [[ "$found" -eq 0 ]]; then
    echo
    echo "No purge targets found in history; rewrite may be unnecessary."
  fi
}

report_tracked_secret_hits() {
  local file hits=0
  echo
  echo "Secret patterns in currently tracked files:"
  while IFS= read -r -d '' file; do
    case "$file" in
      *.example) continue ;;
      tests/*|scripts/*|SECURITY.md) continue ;;
    esac
    if rg -n "$SECRET_CONTENT_PATTERN" "$ROOT/$file" >/dev/null 2>&1; then
      hits=1
      rg -n "$SECRET_CONTENT_PATTERN" "$ROOT/$file" || true
    fi
  done < <(git -C "$ROOT" ls-files -z)

  if [[ "$hits" -eq 0 ]]; then
    echo "  (none)"
  fi
}

report_local_gitignored() {
  local path found=0
  echo
  echo "Gitignored local files on disk (not tracked; safe if never committed):"
  for path in "${paths[@]}"; do
    if [[ -f "$ROOT/$path" ]] && ! git -C "$ROOT" ls-files --error-unmatch "$path" >/dev/null 2>&1; then
      found=1
      echo "  - $path"
    fi
  done
  if [[ "$found" -eq 0 ]]; then
    echo "  (none)"
  fi
}

if [[ "$mode" == "--dry-run" ]]; then
  echo "Would run in: $ROOT"
  echo "git filter-repo ${args[*]}"
  echo
  report_history_paths
  report_tracked_secret_hits
  report_local_gitignored
  exit 0
fi

echo "Rewriting history in $ROOT ..."
cd "$ROOT"
"$GIT_FILTER_REPO" "${args[@]}"

cat <<'EOF'

History rewrite complete.

Next steps:
  1. Run: bash tests/run.sh
  2. Rotate compromised credentials (see SECURITY.md)
  3. Force-push each branch that was ever public or shared:
       git push --force-with-lease origin development
       git push --force-with-lease origin main
  4. Invalidate old clones; ask collaborators to re-clone.

EOF
