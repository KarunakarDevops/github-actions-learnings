targetScope = 'resourceGroup'

param pSqlServerName string 

//Create sql server and database
resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: pSqlServerName
  location: resourceGroup().location
  properties: {
    administratorLogin: 'sqladminuser'
    administratorLoginPassword: 'P@ssword1234'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  parent: sqlServer
  name: 'database1'
  location: resourceGroup().location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
    edition: 'Basic'
    requestedServiceObjectiveName: 'Basic'
  }
  dependsOn: [
    sqlServer
  ]
}

//create sql server fire wall rules
resource sqlServerFirewallRule 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sqlServer
  name: 'karuna Ip address'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}
