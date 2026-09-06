param appServiceName string
param appServicePlanId string
param location string = resourceGroup().location
param sqlConnectionString string

//create app serive
resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      appSettings: [
        {
          name: 'connectionStrings___DefaultConnection'
          value: sqlConnectionString
        }
      ]
    }
  }
}

output appServiceId string = appService.id
output appServiceName string = appService.name
