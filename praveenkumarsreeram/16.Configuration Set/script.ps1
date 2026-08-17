# 1. Create a new key vault service from portal in the same resource group where you will deploy resources.

# 2. Run bicep deployment using below commands.
az login
az deployment group create --name bicep-deployment-dev2 --resource-group "azbicepresourcegroup" --template-file "./main.bicep" --parameters "./main.dev.bicepparam"


