param pVnetName string
param pSubnets array
param location string = resourceGroup().location
param adminUsername string
@secure()
param adminPassword string
param sqlServerName string
param sqlDatabaseName string

param privateEndpointName string

param dnsZoneName string
param groupId string
param virtualNetworkLinkName string

module vnet_Module './modules/vnet.bicep' = {
  name: 'vnet_module'
  params: {
    pVnetName: pVnetName
    pSubnets: pSubnets
  }
}

module sqlServer_Module './modules/sqlServer.bicep' = {
  name: 'sqlServer_module'
  params: {
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
    sqlServerName: sqlServerName
  }
}

module sqlDatabase_Module './modules/sqlDatabase.bicep' = {
  name: 'sqlDatabase_module'
  params: {
    location: location
    sqlServerName: sqlServer_Module.outputs.sqlServerName
    sqlDatabaseName: sqlDatabaseName
  }
}

module dnsZone_Module './modules/privatednsZone.bicep' = {
  name: 'dnsZone_module'
  params: {
    dnsZoneName: dnsZoneName
    pVnetId: vnet_Module.outputs.vNetId
    virtualNetworkLinkName: virtualNetworkLinkName
  }
}

module privateEndpoint_Module './modules/privateEndpoint.bicep' = {
  name: 'privateEndpoint_module'
  params: {
    location: location
    dnsZoneId: dnsZone_Module.outputs.dnsZoneId
    groupId: groupId
    privateEndpointName: privateEndpointName
    resourceId: sqlServer_Module.outputs.sqlServerId
    subnetId: vnet_Module.outputs.privateEndpointSubnetId
  }
}
