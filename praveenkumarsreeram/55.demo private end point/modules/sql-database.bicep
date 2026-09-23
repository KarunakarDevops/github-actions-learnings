@description('Location of the database.')
param location string

@description('SQL server name.')
param sqlServerName string

@description('SQL database name.')
param databaseName string


resource sqlDatabase 'Microsoft.Sql/servers/databases@2025-01-01' = {
  name: databaseName
  location: location

  sku: {
    name: 'Basic'
    tier: 'Basic'
  }

  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
  }
}


output databaseId string = sqlDatabase.id

output databaseName string = sqlDatabase.name
