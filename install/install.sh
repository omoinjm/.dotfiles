#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Linking XDG configs into \$HOME"
"$ROOT/install/link.sh" "$@"

cat <<EOF

Done. Optional next steps:

  Linux shells (bash/zsh): symlink files from platform/linux/shell/ as needed.
  Windows: import platform/windows/powershell/user_profile.ps1 from your profile.
  Secrets: copy templates from secrets/ — see secrets/README.md

EOF
