targetScope = 'resourceGroup'

param pAppServicePlanName string 
param pWebAppName string 
param pAppInsightsInstrumentationKey string

// create app service plan

resource azbicepasp1 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: pAppServicePlanName
  location: resourceGroup().location
  sku: {
    name: 's1'
    capacity: 1
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
        value:pAppInsightsInstrumentationKey
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
