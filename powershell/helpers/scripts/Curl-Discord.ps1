$channelId = "REDACTED"
$token = "REDACTED"
$url = "https://discord.com/api/v10"
$webHook = "https://discord.com/api/webhooks/$channelId/$token"
$secret = "REDACTED"

function send_discord {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    # Create a JSON payload with the message
    $payload = '{\"content\": \"' + $MESSAGE + '\"}'

    # Use curl to send the payload to the webhook URL
    curl -X POST $webHook -H "Content-Type: application/json" -d $payload
}

function send_image {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Path
  )

  curl -X POST $webHook -H "Content-Type: multipart/form-data" -F "file=@$Path" | jq
}

function get_discord {
  curl -H "Authorization: Bot $secret" "$url/1052869571087966208" | jq  
}
