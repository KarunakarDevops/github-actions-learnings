targetScope = 'subscription'

param pResourceGroupName string
param pResourcegroupLocation string

param pAppServicePlanName string
param pWebAppName string
param pAppInsightsName string
param pLogAnalyticsWorkspaceName string 

param pSqlServerName string

module ResourceGroup '1.ResourceGroup.bicep' = {
  name: 'ResourceGroup'
  params: {
    pResourceGroupName: pResourceGroupName
    pResourcegroupLocation: pResourcegroupLocation
  }
}

module AppServiceplan '2.AppServicePlan.bicep' = {
  name: 'AppServiceplan'
  scope: resourceGroup(pResourceGroupName)
  params: {
    pAppServicePlanName: pAppServicePlanName
    pWebAppName: pWebAppName
    pAppInsightsInstrumentationKey: ApplicationInsights.outputs.oAppInsightsInstrumentationKey
  }
  dependsOn: [
    ResourceGroup
  ]
}

module SqlDatabase '3.SqlDatabase.bicep' = {
  name: 'SqlDatabase'
  scope: resourceGroup(pResourceGroupName)
  params: {
    pSqlServerName: pSqlServerName
  }
   dependsOn: [
    ResourceGroup
  ]
}

module ApplicationInsights 'ApplicationInsights.bicep' = {
  name: 'ApplicationInsights'
  scope: resourceGroup(pResourceGroupName)
  params: {
    pAppInsightsName: pAppInsightsName
    pLogAnalyticsWorkspaceName: pLogAnalyticsWorkspaceName
  }
  dependsOn: [
    ResourceGroup
  ]
}
