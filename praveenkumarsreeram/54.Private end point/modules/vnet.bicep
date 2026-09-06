param pVnetName string

param pSubnets array = [
  {
    name: 'snet-sql'
    addressPrefix: '10.0.1.0/24'
  }
  {
    name: 'snet-web'
    addressPrefix: '10.0.2.0/24'
  }
]

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
        }
      }
    ]
  }
}

output vNetId string = virtualNetwork.id
output sqlSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', pVnetName, 'snet-sql')
