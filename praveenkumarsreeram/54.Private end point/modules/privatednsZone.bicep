
param dnsZoneName string
param pVnetId string
param virtualNetworkLinkName string

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: dnsZoneName
  location: 'global'
}

// Create a virtual network link to the DNS zone
resource vnetLink 'Microsoft.Network/dnsZones/virtualNetworkLinks@2018-05-01' = {
  name: virtualNetworkLinkName
  parent: dnsZone
  properties: {
    virtualNetwork: {
      id: pVnetId
    }
    registrationEnabled: false
  }
} 

output dnsZoneId string = dnsZone.id
output dnsZoneName string = dnsZone.name
