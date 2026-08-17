param pAppServicePlanName string = 'az-bicepmodulesplan1-wap1'
param pWebAppName string = 'az-bicep-eus-app1'
param pAppInsightsInstrumentationKey string = 'test instrumentation key'
param pAppServicePlanSkuName string = 'S1'
param pAppServicePlanSkuCapacity int = 2

module appservice_Module 'br:azbicepmodulesacr2.azurecr.io/bicep/appserviceplan:v1' = {
  name: 'appservice_Module'
  params: {
    pAppServicePlanName: pAppServicePlanName
    pWebAppName: pWebAppName
    pAppInsightsInstrumentationKey: pAppInsightsInstrumentationKey
    pAppServicePlanSkuName: pAppServicePlanSkuName
    pAppServicePlanSkuCapacity: pAppServicePlanSkuCapacity
  }
}
