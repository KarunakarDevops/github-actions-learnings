targetScope = 'resourceGroup'

param pEnv string
param pAppServicePlanName string
param pWebAppName string
param pAppInsightsInstrumentationKey string

@description(''' 
Please provide valid SKU name.Valid SKU names are:
- F1 - Free
- D1 - Shared
- B1 - Basic
- B2 - Basic
- B3 - Basic
- S1 - Standard
- S2 - Standard
''')
@allowed(['F1', 'D1', 'B1', 'B2', 'B3', 'S1'])
param pAppServicePlanSkuName string

@maxValue(10)
@minValue(2)
@description(''' 
Please provide the number of instances for the app service plan.
''')
param pAppServicePlanSkuCapacity int

// create app service plan

resource azbicepasp1 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: pAppServicePlanName
  location: resourceGroup().location
  sku: {
    name: pAppServicePlanSkuName
    capacity: pAppServicePlanSkuCapacity
  }
  properties: {
    reserved: false
  }
}

//create web app
resource azbicepas 'Microsoft.Web/sites@2021-02-01' = {
  name: pWebAppName
  location: resourceGroup().location
  properties: {
    serverFarmId: azbicepasp1.id
  }
}

resource azbicepwebapp1appsetting 'Microsoft.Web/sites/config@2021-02-01' = {
  name: 'web'
  parent: azbicepas
  properties: {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: pAppInsightsInstrumentationKey
      }
      {
        name: 'key1'
        value: 'value1'
      }
      {
        name: 'key2'
        value: 'value2'
      }
    ]
  }
}

resource webappSlot 'Microsoft.Web/sites/slots@2021-02-01' = if (pEnv == 'dev') {
  parent: azbicepas
  name: 'staging'
  location: resourceGroup().location
  properties: {
    serverFarmId: azbicepasp1.id
  }
}
