# deploy bicep modules using bicep template at resource group level
az deployment group create --name "bicep-deployment-modules" --resource-group "azbicepresourcegroup" --template-file "./main.bicep"  

