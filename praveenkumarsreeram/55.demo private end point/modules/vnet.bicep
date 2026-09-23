@description('Location of the VNet.')
param location string

@description('Name of the virtual network.')
param vnetName string

@description('Address space for the VNet.')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('Application subnet address prefix.')
param appSubnetPrefix string = '10.0.1.0/24'

@description('SQL private endpoint subnet address prefix.')
param sqlSubnetPrefix string = '10.0.2.0/24'


resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }

    subnets: [
      {
        name: 'snet-app'

        properties: {
          addressPrefix: appSubnetPrefix
        }
      }

      {
        name: 'snet-sql'

        properties: {
          addressPrefix: sqlSubnetPrefix

          // Required/recommended for Private Endpoint scenarios.
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}


output vnetId string = vnet.id

output vnetName string = vnet.name

output sqlSubnetId string = resourceId(
  'Microsoft.Network/virtualNetworks/subnets',
  vnetName,
  'snet-sql'
)

output appSubnetId string = resourceId(
  'Microsoft.Network/virtualNetworks/subnets',
  vnetName,
  'snet-app'
)
