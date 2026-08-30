#create resource group
az group create --name group-bicep --location centralindia

# deploy the ARM template 
az deployment group create --resource-group group-bicep --template-file azuredeploy.json --parameters azuredeploy.parameters.json  

#List az account
az account list --output table

#set subscription
az account set --subscription "Your Subscription Name"

# SHow current account
az account show --output table

#delete resource group
az group delete --name "group-bicep"

# deploy the Bicep template
az deployment group create --resource-group group-bicep --template-file main.bicep --parameters azuredeploy.parameters.json

