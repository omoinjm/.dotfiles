#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_CONFIG="$ROOT/home/.config"
TARGET_CONFIG="${HOME:?}/.config"

usage() {
  cat <<EOF
Usage: $(basename "$0") [app...]

Symlink dotfiles from home/.config into ~/.config.

With no arguments, links: fish, nvim, tmux, lazygit.

Examples:
  $(basename "$0")
  $(basename "$0") fish nvim
EOF
}

link_app() {
  local app="$1"
  local src="$SOURCE_CONFIG/$app"
  local dest="$TARGET_CONFIG/$app"

  if [[ ! -d "$src" ]]; then
    echo "skip: $app (missing $src)"
    return 0
  fi

  mkdir -p "$TARGET_CONFIG"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "warn: $dest exists and is not a symlink; skipping $app"
    return 0
  fi

  ln -sfn "$src" "$dest"
  echo "linked: $dest -> $src"
}

main() {
  local apps=("$@")

  if [[ ${#apps[@]} -eq 0 ]]; then
    apps=(fish nvim tmux lazygit)
  fi

  for app in "${apps[@]}"; do
    link_app "$app"
  done
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

main "$@"
