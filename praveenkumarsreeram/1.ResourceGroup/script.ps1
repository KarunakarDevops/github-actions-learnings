# deploy bicep file at subscription scope
az deployment sub create --name bicep-deployment1 --location centralindia --template-file 1.resourceGroup.bicep

# deploy app service plan bicep
 az deployment group create --name "appserviceplan-deployment" -g "azbicepresourcegroup" -f "2.AppServicePlan.bicep" 