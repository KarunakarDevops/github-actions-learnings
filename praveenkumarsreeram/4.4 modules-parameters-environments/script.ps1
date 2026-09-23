
az group create --name "azbicepresourcegroup-dev" --location "central india"
az group create --name "azbicepresourcegroup-test" --location "central india"
az group create --name "azbicepresourcegroup-prod" --location "central india"

az deployment group create --name main-deployment1 -g "azbicepresourcegroup-dev" --template-file "./main.bicep" --parameters "./main.dev.bicepparam" -c
az deployment group create --name main-deployment2 -g "azbicepresourcegroup-test" --template-file "./main.bicep" --parameters "./main.test.bicepparam" -c
az deployment group create --name main-deployment3 -g "azbicepresourcegroup-prod" --template-file "./main.bicep" --parameters "./main.prod.bicepparam" -c