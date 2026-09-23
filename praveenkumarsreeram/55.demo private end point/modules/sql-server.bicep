@description('Location of the SQL server.')
param location string

@description('Name of the SQL logical server.')
param sqlServerName string

@description('SQL administrator username.')
param administratorLogin string

@secure()
@description('SQL administrator password.')
param administratorLoginPassword string


resource sqlServer 'Microsoft.Sql/servers@2025-01-01' = {
  name: sqlServerName
  location: location

  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword

    version: '12.0'

    // We want SQL to be accessible through
    // the Private Endpoint rather than public networking.
    publicNetworkAccess: 'Disabled'
  }
}


output sqlServerId string = sqlServer.id

output sqlServerName string = sqlServer.name
