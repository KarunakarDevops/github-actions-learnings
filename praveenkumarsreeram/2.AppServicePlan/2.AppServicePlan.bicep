// create app service plan

resource azbicepasp1 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'azbicep-dev-eus-asp1'
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
  name: 'azbicep-dev-eus-webapp1'
  location: resourceGroup().location
  properties: {
    //serverFarmId: azbicepasp1.id
    serverFarmId: resourceId('Microsoft.Web/serverfarms', 'azbicep-dev-eus-asp1')
  }
  dependsOn: [
    azbicepasp1
  ]
}

//create application insights
resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'azbicep-dev-eus-webapp1-ai'
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
