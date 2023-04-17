$DRIVERISK_STAGING = "data source=129.232.226.210,50021; User Id=apps_new;Password=Cx5YRKpgMOQbOSSwSW6J;Database=DriveRiskStaging2"
$DRIVERISK_PRODUCTION = "data source=129.232.226.210,50021; User Id=apps_new;Password=Cx5YRKpgMOQbOSSwSW6J;Database=DriveRiskProduction"

$ByPassAuth = "false"
$AzureShare = "velocity1"
$AzureContainerName = "lytxclipsstaging"
$AzureConnectionString = "DefaultEndpointsProtocol=https;AccountName=lytxclips;AccountKey=axkrXwWsUrdSkGC81tdgX85sgxC1LdN108Zab0Q5HNhwbAgIgZTwxLwfTAWZrF6oWwFqLhYRdd//29xHAhe7iA==;EndpointSuffix=core.windows.net"
$AzureFielStorageConnectionString = "DefaultEndpointsProtocol=https;AccountName=drvelocity;AccountKey=EyjXr0np5mS4zOyRdfy/dEsGVeFb6MQZGVlqWvAXtxp3bCwnESx/s+bumblhwJW9dtmmb6jdgY8cK5O1ITEpBg==;EndpointSuffix=core.windows.net"

# [System.Environment]::SetEnvironmentVariable("DRIVERISK_PRODUCTION", $DRIVERISK_PRODUCTION, "User")
# [System.Environment]::SetEnvironmentVariable("DRIVERISK_STAGING", $DRIVERISK_STAGING, "User")

# [System.Environment]::SetEnvironmentVariable("AzureConnectionString", $AzureConnectionString, "User")
# [System.Environment]::SetEnvironmentVariable("AzureContainerName", $AzureContainerName, "User")
# [System.Environment]::SetEnvironmentVariable("AzureShare", $AzureShare, "User")
# [System.Environment]::SetEnvironmentVariable("AzureFielStorageConnectionString", $AzureFielStorageConnectionString, "User")
# [System.Environment]::SetEnvironmentVariable("ByPassAuth", $ByPassAuth, "User")


