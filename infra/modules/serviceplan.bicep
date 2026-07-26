param namePrefix string
param location string 

@description('The SKU of App Service Plan.')
param sku string = 'B1' // The SKU of App Service Plan

@allowed([
  'dev'
  'test'
  'prod'
])
@description('The environment of the web app')
param environment string = 'dev' // The environment of the web app

var appServicePlanName = toLower('${namePrefix}-AppServicePlan-${environment}')

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output appServicePlanId string = appServicePlan.id
