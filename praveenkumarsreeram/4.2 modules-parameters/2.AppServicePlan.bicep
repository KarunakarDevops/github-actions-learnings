param pAppServicePlanName string 
param pWebAppName string 
param pAppInsightsName string

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
  dependsOn: [
    azbicepasp1
  ]
}

//create application insights
resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: pAppInsightsName
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource azbicepwebapp1appsetting 'Microsoft.Web/sites/config@2021-02-01' = {
  name: 'web'
  parent: azbicepas
  properties: {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: azbicepappinsights.properties.InstrumentationKey
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
  dependsOn: [
    azbicepas
    azbicepappinsights
  ]
}
