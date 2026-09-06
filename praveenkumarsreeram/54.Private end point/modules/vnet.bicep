param pVnetName string

param pSubnets array

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: pVnetName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      for subnet in pSubnets: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.addressPrefix
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

output vNetId string = virtualNetwork.id
output sqlSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', pVnetName, 'snet-sql')
output privateEndpointSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', pVnetName, 'snet-privateendpoints')
