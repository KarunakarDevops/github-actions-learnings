#deploy appservice plan bicep

 az deployment group create --name appserviceplan-deployment -g "azbicepresourcegroup" --template-file "2.AppServicePlan.bicep"

 az deployment group create --name appserviceplan-linux-deployment -g "azbicepresourcegroup" --template-file "2.AppServicePlan.bicep"


 az deployment group create --name appservice-deployment2 -g "azbicepresourcegroup" --template-file "2.AppServicePlan.bicep"

 # deploy appservice and confirm with what if
 az deployment group what-if --name appservice-deployment2 -g "azbicepresourcegroup" --template-file "2.AppServicePlan.bicep"

 # deploy appservice and confirm with  confirm with what if
az deployment group create --name appservice-deployment2 -g "azbicepresourcegroup" --template-file "2.AppServicePlan.bicep" --confirm-with-what-if

az deployment group create --name appservice-deployment2 -g "azbicepresourcegroup" --template-file "2.AppServicePlan.bicep" -c

az deployment group create --name appservice-deployment2 -g "azbicepresourcegroup" --template-file "3.SqlDatabase.bicep" -c
