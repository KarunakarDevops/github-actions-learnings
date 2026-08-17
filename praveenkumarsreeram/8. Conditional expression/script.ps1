# 1. Create a new key vault service from portal in the same resource group where you will deploy resources.

# 2. Run bicep deployment using below commands.
az login
az account set --subscription "<subscription-id>"
az deployment sub what-if --location "centralindia" --template-file "./main.bicep" --parameters "./main.dev.bicepparam"
az deployment sub create --name bicep-deployment-dev2 --location "centralindia" --template-file "./main.bicep" --parameters "./main.dev.bicepparam"


