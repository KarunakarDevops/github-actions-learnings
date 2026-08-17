# 1. Manually resource group and Create a new key vault service from portal.
# 1.1 While creating key vault check Azure Resource Manager for template deployment

# 2. Run bicep deployment using below commands.
az login
az account set --subscription "<subscription-id>"
az deployment sub what-if --location "centralindia" --template-file "./main.bicep" --parameters "./main.dev.bicepparam"
az deployment sub create --name bicep-deployment-dev2 --location "centralindia" --template-file "./main.bicep" --parameters "./main.dev.bicepparam"


