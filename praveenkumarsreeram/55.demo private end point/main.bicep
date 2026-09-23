targetScope = 'resourceGroup'


@description('Location for all resources.')
param location string = resourceGroup().location


@description('Virtual network name.')
param vnetName string = 'vnet-sql-demo'


@description('SQL logical server name. Must be globally unique.')
param sqlServerName string


@description('SQL database name.')
param databaseName string = 'sqldb-demo'


@description('SQL administrator username.')
param sqlAdministratorLogin string


@secure()
@description('SQL administrator password.')
param sqlAdministratorLoginPassword string


@description('Private Endpoint name.')
param privateEndpointName string = 'pe-sql'


@description('Private DNS zone name.')
param privateDnsZoneName string = 'privatelink.database.windows.net'


@description('Windows VM name.')
param vmName string = 'vm-windows-01'

@description('Windows VM administrator username.')
param vmAdminUsername string = 'azureadmin'

@secure()
@description('Windows VM administrator password.')
param vmAdminPassword string

@description('CIDR range allowed to connect to RDP.')
param rdpSourceAddressPrefix string

@description('Windows VM size.')
param vmSize string = 'Standard_B2s'


// ------------------------------------------------------------
// VNET
// ------------------------------------------------------------

module vnet './modules/vnet.bicep' = {
  name: 'deploy-vnet'

  params: {
    location: location
    vnetName: vnetName
    vnetAddressPrefix: '10.0.0.0/16'
    appSubnetPrefix: '10.0.1.0/24'
    sqlSubnetPrefix: '10.0.2.0/24'
  }
}


// ------------------------------------------------------------
// SQL SERVER
// ------------------------------------------------------------

module sqlServer './modules/sql-server.bicep' = {
  name: 'deploy-sql-server'

  params: {
    location: location
    sqlServerName: sqlServerName
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorLoginPassword
  }
}


// ------------------------------------------------------------
// SQL DATABASE
// ------------------------------------------------------------

module sqlDatabase './modules/sql-database.bicep' = {
  name: 'deploy-sql-database'

  params: {
    location: location
    sqlServerName: sqlServerName
    databaseName: databaseName
  }

  dependsOn: [
    sqlServer
  ]
}


// ------------------------------------------------------------
// PRIVATE DNS
// ------------------------------------------------------------

module privateDns './modules/private-dns-zone.bicep' = {
  name: 'deploy-private-dns'

  params: {
    privateDnsZoneName: privateDnsZoneName
    vnetId: vnet.outputs.vnetId
    virtualNetworkLinkName: 'vnet-sql-link'
  }

  dependsOn: [
    vnet
  ]
}


// ------------------------------------------------------------
// PRIVATE ENDPOINT
// ------------------------------------------------------------

module privateEndpoint './modules/private-endpoint.bicep' = {
  name: 'deploy-private-endpoint'

  params: {
    location: location
    privateEndpointName: privateEndpointName

    subnetId: vnet.outputs.sqlSubnetId

    sqlServerId: sqlServer.outputs.sqlServerId

    privateDnsZoneId: privateDns.outputs.privateDnsZoneId
  }

  dependsOn: [
    vnet
    sqlServer
    privateDns
  ]
}


// ------------------------------------------------------------
// Virtual machine
// ------------------------------------------------------------

module windowsVm './modules/windows-vm.bicep' = {
  name: 'deploy-windows-vm'

  params: {
    location: location

    vmName: vmName

    // Use the application subnet.
    subnetId: vnet.outputs.appSubnetId

    adminUsername: vmAdminUsername
    adminPassword: vmAdminPassword

    rdpSourceAddressPrefix: rdpSourceAddressPrefix

    vmSize: vmSize
  }

  dependsOn: [
    vnet
  ]
}


// ------------------------------------------------------------
// OUTPUTS
// ------------------------------------------------------------

output vnetId string = vnet.outputs.vnetId

output sqlServerId string = sqlServer.outputs.sqlServerId

output sqlDatabaseId string = sqlDatabase.outputs.databaseId

output privateEndpointId string = privateEndpoint.outputs.privateEndpointId

output privateDnsZoneId string = privateDns.outputs.privateDnsZoneId

output vmId string = windowsVm.outputs.vmId

output vmName string = windowsVm.outputs.vmName

output vmPrivateIpAddress string = windowsVm.outputs.privateIpAddress

output vmPublicIpAddress string = windowsVm.outputs.publicIpAddress


