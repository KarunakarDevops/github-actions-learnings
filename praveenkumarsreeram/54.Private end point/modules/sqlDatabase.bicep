param location string = resourceGroup().location
param sqlServerName string
param sqlDatabaseName string

resource sqlServer 'Microsoft.Sql/servers@2014-04-01' existing ={
  name: sqlServerName
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
      name: 'Basic'
      tier: 'Basic'
    }
}
output connectionString string = 'Server=tcp:${sqlServer.name}.${environment().suffixes.sqlServerHostname},1433;Initial Catalog=${sqlServerDatabase.name};Persist Security Info=False;User ID=<username>;Password=<password>;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
output sqlDatabaseName string = sqlServerDatabase.name
