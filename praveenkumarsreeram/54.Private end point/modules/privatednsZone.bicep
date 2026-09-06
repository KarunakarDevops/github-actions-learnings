
param dnsZoneName string
param pVnetId string
param virtualNetworkLinkName string

resource dnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: dnsZoneName
  location: 'global'
}

// Create a virtual network link to the DNS zone
resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: virtualNetworkLinkName
  parent: dnsZone
  location: 'global'
  properties: {
    virtualNetwork: {
      id: pVnetId
    }
    registrationEnabled: false
  }
} 

output dnsZoneId string = dnsZone.id
output dnsZoneName string = dnsZone.name
