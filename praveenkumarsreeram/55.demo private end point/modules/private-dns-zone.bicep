@description('Private DNS zone name.')
param privateDnsZoneName string = 'privatelink.database.windows.net'

@description('Virtual network ID to link to the DNS zone.')
param vnetId string

@description('Name of the DNS zone VNet link.')
param virtualNetworkLinkName string


resource privateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZoneName
  location: 'global'
}


resource dnsZoneVnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZone

  name: virtualNetworkLinkName

  properties: {
    registrationEnabled: false

    virtualNetwork: {
      id: vnetId
    }
  }
}


output privateDnsZoneId string = privateDnsZone.id

output privateDnsZoneName string = privateDnsZone.name
