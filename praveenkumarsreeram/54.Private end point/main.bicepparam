using './main.bicep'

param pVnetName = 'az-pep-dev-cus-vnet01-bicep'

param pSubnets = [
  {
    name: 'snet-sql'
    addressPrefix: '10.0.1.0/24'
  }
  {
    name: 'snet-web'
    addressPrefix: '10.0.2.0/24'
  }
]

param location = 'centralindia'
param adminUsername = 'sqladminuser'
param adminPassword = 'P@ssw0rd1234'
param sqlServerName = 'az-pep-dev-cus-sqlserver2'
param sqlDatabaseName = 'database1'

param dnsZoneName = 'privatelink.database.windows.net'
param virtualNetworkLinkName = 'vnet-sql-link'
param privateEndpointName = 'pe-${sqlServerName}'
param groupId = 'sqlServer'

param appServicePlanName = 'az-pep-dev-cus-appserviceplan'
param appServiceName = 'az-pep-dev-cus-appservice'

param dnsZoneName_AppService = 'privatelink.azurewebsites.net'
param virtualNetworkLinkName_AppService = 'vnet-appservice-link'
param privateEndpointName_AppService = 'pe-${appServiceName}'
param groupId_AppService = 'sites'
