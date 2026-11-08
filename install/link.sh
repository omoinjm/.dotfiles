#!/usr/bin/env bash
# Apply the dotfiles in home/ to $HOME with chezmoi.
#
# Uses a dedicated chezmoi config (~/.config/chezmoi-dotfiles/) so it never
# touches the default ~/.config/chezmoi/, which machine-snapshot owns.
# Kept under this name because ubuntu-setup calls install/link.sh.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME:?}/.config}"
CZ_CONFIG="$CONFIG_DIR/chezmoi-dotfiles/chezmoi.toml"
LEGACY_APPS=(fish nvim tmux lazygit git oh-my-posh)

usage() {
  cat <<EOF
Usage: $(basename "$0") [app...] [-- chezmoi apply flags]

Apply the dotfiles with chezmoi (symlink mode: files in ~/.config link back
into $ROOT/home).

With no app names, applies everything. Otherwise only ~/.config/<app>.

Examples:
  $(basename "$0")
  $(basename "$0") fish nvim
  $(basename "$0") -- --dry-run --verbose
EOF
}

find_chezmoi() {
  if command -v chezmoi >/dev/null 2>&1; then
    command -v chezmoi
  elif [[ -x "$HOME/.local/bin/chezmoi" ]]; then
    echo "$HOME/.local/bin/chezmoi"
  else
    echo "==> Installing chezmoi into ~/.local/bin" >&2
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" >&2
    echo "$HOME/.local/bin/chezmoi"
  fi
}

# Before chezmoi, each app dir was one symlink into this repo. Remove those so
# chezmoi can create real directories (only links that point into this repo).
remove_legacy_links() {
  local app dest
  for app in "${LEGACY_APPS[@]}"; do
    dest="$CONFIG_DIR/$app"
    if [[ -L "$dest" && "$(readlink "$dest")" == "$ROOT/"* ]]; then
      rm "$dest"
      echo "removed legacy link: $dest"
    fi
  done
}

main() {
  local -a apps=() flags=() targets=()
  while (($#)); do
    case "$1" in
      -h|--help) usage; exit 0 ;;
      --) shift; flags=("$@"); break ;;
      *) apps+=("$1") ;;
    esac
    shift
  done

  local cz
  cz="$(find_chezmoi)"

  remove_legacy_links
  "$cz" --config "$CZ_CONFIG" init --source "$ROOT"

  for app in "${apps[@]}"; do targets+=("$CONFIG_DIR/$app"); done
  "$cz" --config "$CZ_CONFIG" apply "${flags[@]}" "${targets[@]}"
  echo "applied dotfiles from $ROOT/home (manage with: dot status | dot diff | dot apply)"
}

main "$@"
