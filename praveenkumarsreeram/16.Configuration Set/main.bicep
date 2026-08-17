targetScope = 'subscription'

param pEnv string
param pResourceGroupName string
param pResourcegroupLocation string

param pAppServicePlanName string
param pWebAppName string
param pAppInsightsName string
param pLogAnalyticsWorkspaceName string

param pSqlServerName string

param pAdministratorLogin string

param pKeyVaultName string

// param pAppServicePlanSkuName string = (pEnv == 'dev') ? 'F1' : (pEnv == 'prod') ? 'S1' : 'B1'
// param pAppServicePlanSkuCapacity int = (pEnv == 'dev') ? 2 : (pEnv == 'prod') ? 3 : 1

var vConfigurations={
  prod:{
    AppServicePlan:{
      SkuName:'S1'
      SkuCapacity:3
    }
  }
  dev:{
    AppServicePlan:{
      SkuName:'F1'
      SkuCapacity:2
    }
  }
}
module ResourceGroup '1.ResourceGroup.bicep' = {
  name: 'ResourceGroup'
  params: {
    pResourceGroupName: pResourceGroupName
    pResourcegroupLocation: pResourcegroupLocation
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-10-01' existing = {
  name: pKeyVaultName
  scope: resourceGroup(pResourceGroupName)
}

module AppServiceplan '2.AppServicePlan.bicep' = {
  name: 'AppServiceplan'
  scope: resourceGroup(pResourceGroupName)
  params: {
    pAppServicePlanName: pAppServicePlanName
    pWebAppName: pWebAppName
    pAppInsightsInstrumentationKey: ApplicationInsights.outputs.oAppInsightsInstrumentationKey
    pAppServicePlanSkuName: vConfigurations[pEnv].AppServicePlan.SkuName
    pAppServicePlanSkuCapacity: vConfigurations[pEnv].AppServicePlan.SkuCapacity
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
    pAdministratorLogin: pAdministratorLogin
    pAdministratorLoginPassword: keyVault.getSecret('SqlAdminPassword')
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
