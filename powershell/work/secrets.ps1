Import-Module -Name "$env:dotfiles\powershell\work\env.ps1"

# Optix Azure Secrets
$env:optix_sub = '2e3867b0-d7d6-4e7a-a16c-becdbd1d54da'
$env:username = 'junior.malaza@rysis.co.za'
$env:password = ConvertTo-SecureString "XzDvITUS3f85GHM4rkBc" -AsPlainText -Force
$env:tenantId = '6203eb7b-95ee-494e-bd20-3aad298b7d6c'
$env:clientId = '4cfa7f8c-d5ab-4ccc-8612-eec3a5fb833e'
$env:client_secret = 'm6J8Q~RxMsTk.kUo-yoj3WVcy-lnjA7WfFQKLa~U'

# Rysis
$env:rysis_sub = '2f33be9a-cc6e-43df-87c8-96fa5ec0d5a8'

# Visibill

# Atrax

