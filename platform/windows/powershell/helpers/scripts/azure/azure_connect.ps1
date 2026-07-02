# Define variables
# $credential = New-Object System.Management.Automation.PSCredential ($env:username, $env:password);

# Create the authentication provider
# $client_credential = New-Object -TypeName Microsoft.Graph.Auth.ClientCredential -ArgumentList $env:clientId, $env:client_secret
		
# $auth_provider = New-Object -TypeName Microsoft.Graph.Auth.DeviceCodeProvider -ArgumentList $client_credential

# Authenticate with Azure AD using the ApplicationId, TenantId, and Client Secret
# $secure_string_password = ConvertTo-SecureString -String $env:client_secret -AsPlainText -Force
# $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $clientId, $secure_string_password

#function az_connect {
#  Connect-AzureAD -TenantId $env:tenantId -Credential $cred
#}

#function azure_connect { 
#  Connect-AzureAD -Credential $credential
#}

#function az_graph {
#  Connect-MgGraph -TenantId $env:tenantId -AuthenticationProvider $auth_provider
#}
