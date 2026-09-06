param privateEndpointName string
param location string = resourceGroup().location
param dnsZoneId string
param subnetId string

@description('The resource ID of the azure resource.')
param resourceId string
param groupId string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-08-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: '${privateEndpointName}-connection'
        properties: {
          privateLinkServiceId: resourceId
          groupIds: [
            groupId
          ]
          requestMessage: 'Please approve my connection.'
        }
      }
    ]
  }
}

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-08-01' = {
  name: 'default'
  parent: privateEndpoint
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'sql-dns-zone'
        properties: {
          privateDnsZoneId: dnsZoneId
        }
      }
    ]
  }
}

output privateEndpointId string = privateEndpoint.id
output privateEndpointName string = privateEndpoint.name

