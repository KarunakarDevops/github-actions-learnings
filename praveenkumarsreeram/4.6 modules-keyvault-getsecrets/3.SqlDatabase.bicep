targetScope = 'resourceGroup'

param pSqlServerName string 

param pAdministratorLogin string
@secure()
param pAdministratorLoginPassword string 

//Create sql server and database
resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: pSqlServerName
  location: resourceGroup().location
  properties: {
    administratorLogin: pAdministratorLogin
    administratorLoginPassword: pAdministratorLoginPassword
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

//create array of firewall rules
var firewallRules = [
  {
    name: 'AllowAllWindowsAzureIps'
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
  {
    name: 'AllowMyIP'
    startIpAddress: '49.207.152.71'
    endIpAddress: '49.207.152.71'
  }
]

//create firewall rules using for loop
resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = [for rule in firewallRules: {
  parent: sqlServer
  name: rule.name
  properties: {
    startIpAddress: rule.startIpAddress
    endIpAddress: rule.endIpAddress
  }
}]
