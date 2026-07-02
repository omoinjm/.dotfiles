# Local secrets (never commit real values)

Tracked files here are **examples only**. Copy them to machine-local paths and edit with your values.

## Fish

```bash
cp secrets/fish/secrets.fish.example ~/.config/fish/conf.d/secrets.fish
cp secrets/fish/ssh.fish.example ~/.config/fish/conf.d/ssh.fish
```

These paths are gitignored. `00-local.fish` loads them automatically when present.

## Discord (PowerShell)

Set environment variables (or add to your PowerShell profile):

```powershell
$env:DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/<channel-id>/<token>"
$env:DISCORD_BOT_TOKEN = "<bot-token>"
```

See `secrets/discord/env.example` for usage with `platform/windows/powershell/helpers/scripts/webhooks/curl_discord.ps1`.

## Password store

Export private keys locally only. See `secrets/password-store/exported-keys/private.pgp.example`.
