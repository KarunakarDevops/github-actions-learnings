#Deploy bicep file in the current directory

az deployment group create -g "azbicepresourcegroup" -f "11.Keyvault.bicep"

az deployment group create --name "bicep-deployment-keyvault" --resource-group "azbicepresourcegroup" --template-file "./11.Keyvault.bicep" --parameters "./11.Keyvault.bicepparam" 

az deployment group create --name "bicep-deployment-keyvault" --resource-group "azbicepresourcegroup" --template-file "./11.Keyvault.bicep" --parameters "./11.Keyvault.bicepparam"
