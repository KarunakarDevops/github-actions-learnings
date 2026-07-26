param location string
param namePrefix string
param environment string = 'dev' // The environment of the web app
var webAppNameFinal = toLower('${namePrefix}-webapp-${environment}')
param linuxFxVersion string
param appServicePlanId string

resource webApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppNameFinal
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVICE_URL'
          value: 'https://index.docker.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ''
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
    }
    httpsOnly: true
  }
}

output siteUrl string = webApp.properties.hostNames[0]
