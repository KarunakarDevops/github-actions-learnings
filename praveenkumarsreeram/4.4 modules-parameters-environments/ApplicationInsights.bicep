
param pAppInsightsName string

//create application insights
resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: pAppInsightsName
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output oAppInsightsInstrumentationKey string = azbicepappinsights.properties.InstrumentationKey 

