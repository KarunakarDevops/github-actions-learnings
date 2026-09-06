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

//Sql database
param adminUsername = 'sqladminuser'
param adminPassword = 'P@ssw0rd1234'
param sqlServerName = 'az-pep-dev-cus-sqlserver2'
param sqlDatabaseName = 'database1'

//Sql database private end point
param dnsZoneName = 'privatelink.database.windows.net'
param virtualNetworkLinkName = 'vnet-sql-link'
param privateEndpointName = 'pe-${sqlServerName}'
param groupId = 'sqlServer'

//App service
param appServicePlanName = 'az-pep-dev-cus-appserviceplan'
param appServiceName = 'az-pep-dev-cus-appservice'

//App service private end point
param dnsZoneName_AppService = 'privatelink.azurewebsites.net'
param virtualNetworkLinkName_AppService = 'vnet-appservice-link'
param privateEndpointName_AppService = 'pe-${appServiceName}'
param groupId_AppService = 'sites'


// Windows VM

param vmName = 'vm-windows-01'

param vmAdminUsername = 'azureadmin'

param vmAdminPassword = 'Karuna@3435#'

param vmSize = 'Standard_D2s_v3'


// Replace with your own public IP/CIDR.
// Example: 203.0.113.10/32

param rdpSourceAddressPrefix = 'YOUR_PUBLIC_IP/32'
