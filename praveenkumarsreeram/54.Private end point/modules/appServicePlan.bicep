param appServicePlanName string
param location string
param skuName string='b1'
param skuTier string='Basic'

//create app service plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: skuTier
  }
}

output appServicePlanId string = appServicePlan.id
