targetScope = 'subscription'

param pResourceGroupName string 
param pResourcegroupLocation string 

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: pResourceGroupName
  location: pResourcegroupLocation
}

output oResourceGroupName string = resourceGroup.name
output oResourceGroupId string = resourceGroup.id
