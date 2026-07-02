# Security

This repository is intended to be safe to publish. Real credentials must never be committed.

## Local-only files

Copy templates from `secrets/` and keep real values on each machine only:

| Local path | Template |
|------------|----------|
| `~/.config/fish/conf.d/secrets.fish` | `secrets/fish/secrets.fish.example` |
| `~/.config/fish/conf.d/ssh.fish` | `secrets/fish/ssh.fish.example` |
| `secrets/password-store/exported-keys/private.pgp` | `secrets/password-store/exported-keys/private.pgp.example` |
| `secrets/password-store/exported-keys/public.pgp` | `secrets/password-store/exported-keys/public.pgp.example` |

Fish loads `conf.d/secrets.fish` and `conf.d/ssh.fish` via `conf.d/00-local.fish` when they exist.

## Before making the repo public

1. Run the safety checks:
   ```bash
   bash tests/run.sh
   ```
2. Confirm no secret paths are tracked:
   ```bash
   git ls-files | rg 'conf\.d/secrets\.fish$|conf\.d/ssh\.fish$|/private\.pgp$|/public\.pgp$|fish_variables$'
   ```
   This should print nothing.
3. Install `git-filter-repo` if needed (on WSL/Debian/Ubuntu, use apt — not `pip install`):
   ```bash
   sudo apt install git-filter-repo
   ```
4. Purge secrets from git history (required if credentials were ever committed):
   ```bash
   scripts/purge-secrets-from-history.sh --dry-run
   scripts/purge-secrets-from-history.sh --execute
   git push --force-with-lease origin development
   git push --force-with-lease origin main
   ```
5. **Rotate** anything that was ever in git:
   - GPG passphrase used by `secrets.fish`
   - PGP key pair under `password-store/exported-keys/`
   - Discord webhooks or bot tokens referenced in PowerShell helpers
6. Re-clone on every machine after the history rewrite.

## If you accidentally commit a secret

1. Remove it from the index immediately:
   ```bash
   git rm --cached path/to/secret/file
   ```
2. Rotate the exposed credential.
3. Run `scripts/purge-secrets-from-history.sh --execute` before pushing or going public.
4. Do not rely on `.gitignore` alone — ignored files can remain tracked until removed with `git rm --cached`.

## CI

GitHub Actions runs `tests/run.sh` on push and pull requests. The test suite scans **tracked files only** so gitignored local secrets on a developer machine do not cause false positives.
