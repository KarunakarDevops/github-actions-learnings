param location string = resourceGroup().location
param adminUsername string 
param adminPassword string
param sqlServerName string


//Create sql server with private endpoint and private dns zone

resource sqlServer 'Microsoft.Sql/servers@2021-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
  }
}
output sqlServerId string = sqlServer.id
output sqlServerName string = sqlServer.name

