function az_env {
  [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$appName,
        [Parameter(Mandatory=$true)]
        [string]$subscriptionId,
        [Parameter(Mandatory=$true)]
        [string]$resourceGroup
    )

  # Set the desired subscription
  az account set --subscription $subscriptionId

  $appSettingsJson = az functionapp config appsettings list --name $appName --resource-group $resourceGroup | ConvertFrom-Json
 
  # Update local.settings.json
  $localSettingsFile = "./local.settings.json"
  $localSettings = Get-Content -Path $localSettingsFile | ConvertFrom-Json

  # echo $appSettingsJson

  foreach ($setting in $appSettingsJson) {
    $localSettings.Values[$setting.name] = $setting.value
  }

  cat $localSettingsFile

  # $localSettingsJson = $localSettings | ConvertTo-Json -Depth 4
  # $localSettingsJson | Out-File -FilePath $localSettingsFile -Force

  # Write-Host "Local environment settings updated successfully."
}
