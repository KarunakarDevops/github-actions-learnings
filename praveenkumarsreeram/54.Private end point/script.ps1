az deployment group create --name bicep-deployment-vnet --resource-group "azbicepresourcegroup" --template-file "./main.bicep" --parameters "./main.bicepparam"

nslookup app_service_name.azurewebsites.net
