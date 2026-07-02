# Discord helpers. Set DISCORD_WEBHOOK_URL (and optionally DISCORD_BOT_TOKEN) in your environment.
# See curl_discord.ps1.example for setup.

function send_discord {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    if (-not $env:DISCORD_WEBHOOK_URL) {
        Write-Error "DISCORD_WEBHOOK_URL is not set."
        return
    }

    $payload = @{ content = $Message } | ConvertTo-Json -Compress
    curl -X POST $env:DISCORD_WEBHOOK_URL -H "Content-Type: application/json" -d $payload
}

function send_image {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not $env:DISCORD_WEBHOOK_URL) {
        Write-Error "DISCORD_WEBHOOK_URL is not set."
        return
    }

    curl -X POST $env:DISCORD_WEBHOOK_URL -H "Content-Type: multipart/form-data" -F "file=@$Path" | jq
}

function get_discord {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ChannelId
    )

    if (-not $env:DISCORD_BOT_TOKEN) {
        Write-Error "DISCORD_BOT_TOKEN is not set."
        return
    }

    $url = if ($env:DISCORD_API_URL) { $env:DISCORD_API_URL } else { "https://discord.com/api/v10" }
    curl -H "Authorization: Bot $env:DISCORD_BOT_TOKEN" "$url/channels/$ChannelId" | jq
}
