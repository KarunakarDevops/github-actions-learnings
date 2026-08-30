az deployment group create --name bicep-deployment-nsg --resource-group "azbicepresourcegroup" --template-file "./main.bicep" --parameters "./main.bicepparam"


az deployment group create --name bicep-deployment-nsg-dev --resource-group "azbicepresourcegroup" --template-file "./main.bicep" --parameters "./main.dev.bicepparam"

az deployment group create --name bicep-deployment-nsg-prod --resource-group "azbicepresourcegroup" --template-file "./main.bicep" --parameters "./main.prod.bicepparam"
