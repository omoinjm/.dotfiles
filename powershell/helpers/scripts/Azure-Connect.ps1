# Define variables
$password = ConvertTo-SecureString "XzDvITUS3f85GHM4rkBc" -AsPlainText -Force;
$username = "junior.malaza@rysis.co.za";
$tenantId = "6203eb7b-95ee-494e-bd20-3aad298b7d6c";
$clientId = "4cfa7f8c-d5ab-4ccc-8612-eec3a5fb833e";
$clientSecret = "m6J8Q~RxMsTk.kUo-yoj3WVcy-lnjA7WfFQKLa~U";

$credential = New-Object System.Management.Automation.PSCredential ($username, $password);

# Create the authentication provider
# $ClientCredential = New-Object -TypeName Microsoft.Graph.Auth.ClientCredential -ArgumentList $clientId, $clientSecret
# $AuthenticationProvider = New-Object -TypeName Microsoft.Graph.Auth.DeviceCodeProvider -ArgumentList $ClientCredential

# Authenticate with Azure AD using the ApplicationId, TenantId, and Client Secret
$SecureStringPassword = ConvertTo-SecureString -String $clientSecret -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $clientId, $SecureStringPassword

function az-connect {
  Connect-AzureAD -TenantId $tenantId -Credential $Credential
}

function azure-connect { 
  Connect-AzureAD -Credential $credential
}

# function az-graph {
#  Connect-MgGraph -TenantId $tenantId -AuthenticationProvider $AuthenticationProvider
# }
