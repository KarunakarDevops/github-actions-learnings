targetScope = 'subscription'

param location string 
param namePrefix string
param environment string  // The environment of the web app

param storageName string  // The name of the storage account
param storageSku string // The SKU of the storage account

param appServicePlanSku string = 'B1' // The SKU of App Service Plan
param linuxFxVersion string  // The runtime stack of web app

param groupName string  // The name of the resource group
var resourceGroupName = toLower('${namePrefix}-${groupName}-${environment}') // The name of the resource group


module resourceGroupModule 'modules/resourceGroup.bicep' = {
  name: 'resourceGroupModule'
  params: {
    groupName: groupName
    location: location
    namePrefix: namePrefix
    environment: environment
  }
}

//Consume the modules
module storageModule 'modules/storage.bicep' = {
  name: 'storageModule'
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    resourceGroupModule
  ]
  params: {
    namePrefix: namePrefix
    skuName: storageSku
    storageName: storageName
    location: location
    environment: environment
  }
}

module servicePlanModule 'modules/serviceplan.bicep' = {
  name: 'servicePlanModule'
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    resourceGroupModule
  ]
  params: {
    namePrefix: namePrefix
    location: location
    sku: appServicePlanSku
    environment: environment
  }
}

module webAppModule 'modules/webApp.bicep' = {
  name: 'webAppModule'
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    resourceGroupModule
  ]
  params: {
    namePrefix: namePrefix
    location: location
    environment: environment
    linuxFxVersion: linuxFxVersion
    appServicePlanId: servicePlanModule.outputs.appServicePlanId
  }
}

output  siteUrl string = webAppModule.outputs.siteUrl
