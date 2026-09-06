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

param appServicePlanName string
param appServiceName string


param dnsZoneName_AppService string = 'privatelink.azurewebsites.net'
param virtualNetworkLinkName_AppService string = 'vnet-appservice-link'
param privateEndpointName_AppService string = 'pe-${appServiceName}'
param groupId_AppService string = 'sqlServer'


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
    sqlUsername: adminUsername
    sqlPassword: adminPassword
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
    subnetId: vnet_Module.outputs.sqlSubnetId
  }
}

module appService_Plan_Module './modules/appServicePlan.bicep' = {
  name: 'appServicePlan_module'
  params: {
    location: location
    appServicePlanName: appServicePlanName
  }
}
module appService_Module './modules/appService.bicep' = {
  name: 'appService_module'
  params: {
    appServiceName: appServiceName
    location: location
    sqlConnectionString: sqlDatabase_Module.outputs.connectionString
    appServicePlanId: appService_Plan_Module.outputs.appServicePlanId
    
  }
}

//create private dns zone for app service
module appServiceDnsZone_Module './modules/privatednsZone.bicep' = {
  name: 'appServiceDnsZone_module'
  params: {
    dnsZoneName: dnsZoneName_AppService
    pVnetId: vnet_Module.outputs.vNetId
    virtualNetworkLinkName: virtualNetworkLinkName_AppService
  }
}

//create private endpoint for app service
module appServicePrivateEndpoint_Module './modules/privateEndpoint.bicep' = {
  name: 'appServicePrivateEndpoint_module'
  params: {
    location: location
    dnsZoneId: appServiceDnsZone_Module.outputs.dnsZoneId
    groupId: groupId_AppService
    privateEndpointName: privateEndpointName_AppService
    resourceId: appService_Module.outputs.appServiceId
    subnetId: vnet_Module.outputs.webSubnetId
  }
}

module windowsVm './modules/virtualmachine.bicep' = {
  name: 'deploy-windows-vm'

  params: {
    location: location

    vmName: vmName

    // Use the application subnet.
    subnetId: vnet_Module.outputs.webSubnetId

    adminUsername: vmAdminUsername
    adminPassword: vmAdminPassword

    rdpSourceAddressPrefix: rdpSourceAddressPrefix

    vmSize: vmSize
  }

  dependsOn: [
    vnet_Module
  ]
}
