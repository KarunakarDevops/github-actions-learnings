param pAppServicePlanName string = 'azbicep-dev-eus-asp1'
param pWebAppName string = 'azbicep-dev-eus-webapp1'
param pAppInsightsName string = 'azbicep-dev-eus-webapp1-ai'
// param pSqlServerName string = 'azbicep-dev-eus-sqlserver1'


module AppServiceplan '2.AppServicePlan.bicep' = {
  name: 'AppServiceplan'
  params: {
    pAppServicePlanName: pAppServicePlanName
    pWebAppName: pWebAppName
    pAppInsightsInstrumentationKey: ApplicationInsights.outputs.oAppInsightsInstrumentationKey
  }
}

// module SqlDatabase '3.SqlDatabase.bicep' = {
//   name: 'SqlDatabase'
//   params: {
//     pSqlServerName: pSqlServerName
//   }
// }

module ApplicationInsights 'ApplicationInsights.bicep' = {
  name: 'ApplicationInsights'
  params: {
    pAppInsightsName: pAppInsightsName
  }
}
