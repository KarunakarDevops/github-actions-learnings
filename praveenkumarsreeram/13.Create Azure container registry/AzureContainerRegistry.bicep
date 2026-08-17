param pACRName string = 'azbicepmodulesacr2'

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: pACRName
  location: resourceGroup().location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}
