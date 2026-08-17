
param pNetworkSecurityGroupName string
param Location string = resourceGroup().location

var nsg_rules=[
  {
    name: 'AllowSSH'
    properties: {
      priority: 1000
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
      sourceAddressPrefix: '*'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '22'
    }
  }
  {
    name: 'Allow-8080'
    properties: {
      priority: 1001
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
      sourceAddressPrefix: 'Internet'
      sourcePortRange: '8080'
      destinationAddressPrefix: '*'
      destinationPortRange: '8080'
    }
  }
  {
    name: 'AllowHTTPS'
    properties: {
      priority: 1002
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
      sourceAddressPrefix: '*'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '443'
    }
  }
]
resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: pNetworkSecurityGroupName
  location: Location
  properties: {
    securityRules: nsg_rules
  }
}
