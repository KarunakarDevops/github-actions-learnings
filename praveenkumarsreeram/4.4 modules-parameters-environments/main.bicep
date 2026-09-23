param pAppServicePlanName string 
param pWebAppName string 
param pAppInsightsName string 
// param pSqlServerName string 


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
