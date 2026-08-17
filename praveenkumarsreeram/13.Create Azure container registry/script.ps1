# deploy Azure Container Registry using bicep template

az deployment group create --name "bicep-deployment-acr" --resource-group "azbicepresourcegroup" --template-file "./AzureContainerRegistry.bicep" 
//--parameters "./AzureContainerRegistry.bicepparam"
