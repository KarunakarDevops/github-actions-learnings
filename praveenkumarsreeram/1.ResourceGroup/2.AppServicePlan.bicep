
resource appServicePlan1 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'azbicep-dev-eus-asp1'
  location: resourceGroup().location
  sku: {
    name: 's1'
    capacity: 1
  }
  properties: {
    reserved: false
  }
}


// Create linux app service plan
resource linuxAppServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'azbicep-dev-eus-linux-asp1'
  location: resourceGroup().location
  kind: 'linux'
  sku: {
    name: 'S1'
    capacity: 1
  }
  properties: {
    reserved: true
  }
}
