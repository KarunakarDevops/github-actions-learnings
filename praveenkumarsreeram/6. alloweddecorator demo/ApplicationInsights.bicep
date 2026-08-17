targetScope = 'resourceGroup'

param pAppInsightsName string
param pLogAnalyticsWorkspaceName string 

//create application insights
resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: pAppInsightsName
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2025-07-01' = {
  name: pLogAnalyticsWorkspaceName
  location: resourceGroup().location
  properties: {
    retentionInDays: 30
  }
}

output oAppInsightsInstrumentationKey string = azbicepappinsights.properties.InstrumentationKey 

