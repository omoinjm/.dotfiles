<<<<<<< HEAD
$channelId = "1082216109090029608"
$token = "Q86dPENBZPLauuqW50803Idqh7Pn9zV54Tqdmxst0pgUIGXLr1yBt2_B1K3XzzLpFeXW"
$url = "https://discord.com/api/v10"
$webHook = "https://discord.com/api/webhooks/$channelId/$token"
$secret = "LIlK0KKvPOu99c_NqAsQs7FQtFphL3He"
=======
$channelId = "REDACTED"
$token = "REDACTED"
$url = "https://discord.com/api/v10"
$webHook = "https://discord.com/api/webhooks/$channelId/$token"
$secret = "REDACTED"
>>>>>>> 926ab7c957bf48aab795bcbafe8d03ad11f46eeb

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
