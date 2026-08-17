
az login
az account set --subscription "<subscription-id>"
az deployment sub what-if --location "centralindia" --template-file "./main.bicep" --parameters "./main.prod.bicepparam"
az deployment sub create --name bicep-deployment --location "centralindia" --template-file "./main.bicep" --parameters "./main.prod.bicepparam"


