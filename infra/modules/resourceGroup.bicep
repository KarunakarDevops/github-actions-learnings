targetScope = 'subscription'

param groupName string  // The name of the resource group
param location string // The location of the resource group
param namePrefix string // The prefix for the resources
param environment string  // The environment of the resources

var resourceGroupName = toLower('${namePrefix}-${groupName}-${environment}') // The name of the resource group

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

output resourceGroupName string = rg.name
