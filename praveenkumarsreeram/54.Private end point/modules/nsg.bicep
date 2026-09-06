@description('Location of the NSG.')
param location string

@description('Name of the Network Security Group.')
param nsgName string

@description('CIDR range allowed to connect through RDP.')
param rdpSourceAddressPrefix string


resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: nsgName
  location: location

  properties: {
    securityRules: [
      {
        name: 'Allow-RDP'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'

          sourcePortRange: '*'
          destinationPortRange: '3389'

          sourceAddressPrefix: rdpSourceAddressPrefix
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

output nsgId string = nsg.id
