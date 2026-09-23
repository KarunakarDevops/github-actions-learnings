@description('Location of the Private Endpoint.')
param location string

@description('Private Endpoint name.')
param privateEndpointName string

@description('Subnet ID where the Private Endpoint will be deployed.')
param subnetId string

@description('SQL server resource ID.')
param sqlServerId string

@description('Private DNS zone resource ID.')
param privateDnsZoneId string


resource privateEndpoint 'Microsoft.Network/privateEndpoints@2024-05-01' = {
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
          privateLinkServiceId: sqlServerId

          groupIds: [
            'sqlServer'
          ]

          requestMessage: 'Private endpoint connection for Azure SQL.'
        }
      }
    ]
  }
}


resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-05-01' = {
  parent: privateEndpoint

  name: 'default'

  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'sql-dns-zone'
        properties: {
          privateDnsZoneId: privateDnsZoneId
        }
      }
    ]
  }
}


output privateEndpointId string = privateEndpoint.id
