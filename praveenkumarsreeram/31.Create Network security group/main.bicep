param pNetworkSecurityGroupName string
param pEnvironment string = 'dev'

var nsg_rules = [
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

var nsg_dev_rules = [
  {
    name: 'Allow-3389'
    properties: {
      priority: 1003
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
      sourceAddressPrefix: 'Internet'
      sourcePortRange: '3389'
      destinationAddressPrefix: '*'
      destinationPortRange: '3389'
    }
  }
]

// Logical parameter pattern
var nsg_final_rules = pEnvironment != 'dev' ? nsg_rules : concat(nsg_rules, nsg_dev_rules)

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: pNetworkSecurityGroupName
  location: resourceGroup().location
  properties: {
    securityRules: nsg_final_rules
  }
}
