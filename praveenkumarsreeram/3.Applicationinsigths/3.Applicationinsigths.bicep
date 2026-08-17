//create application insights
resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'azbicep-dev-eus-webapp1-ai'
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
