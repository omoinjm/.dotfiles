function az_env {
  [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$app_name,
        [Parameter(Mandatory=$true)]
        [string]$subscriptionId,
        [Parameter(Mandatory=$true)]
        [string]$resource_group
    )

  # Set the desired subscription
  az account set --subscription $subscriptionId

  $app_settings_json = az functionapp config appsettings list --name $app_name --resource-group $resource_group | ConvertFrom-Json
 
  # Update local.settings.json
  $local_settings_file = "./local.settings.json"
  $local_settings = Get-Content -Path $local_settings_file | ConvertFrom-Json

  # echo $app_settings_json

  foreach ($setting in $app_settings_json) {
    $local_settings.Values[$setting.name] = $setting.value
  }

  # cat $local_settings_file

  # $local_settings_json = $local_settings | ConvertTo-Json -Depth 4
  # $local_settings_json | Out-File -FilePath $local_settings_file -Force

  echo "Local environment settings updated successfully."
}
