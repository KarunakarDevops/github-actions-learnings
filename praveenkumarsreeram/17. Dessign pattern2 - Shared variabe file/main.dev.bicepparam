using './main.bicep'

var prefixes=loadJsonContent('sharedvariables.json')

param pEnv = 'dev'
param pResourceGroupName = 'azbicepresourcegroup'
param pResourcegroupLocation = 'centralindia'

param pAppServicePlanName = '${prefixes.projectPrefix}-dev-eus-${prefixes.appserviceplanprefix}1'
param pWebAppName = '${prefixes.projectPrefix}-dev-eus-'
param pAppInsightsName = '${prefixes.projectPrefix}-dev-eus-webapp1-${prefixes.appinsightsprefix}'
param pLogAnalyticsWorkspaceName = '${prefixes.projectPrefix}-dev-eus-webapp1-${prefixes.loganalyticsworkspaceprefix}'


param pSqlServerName = '${prefixes.projectPrefix}-dev-eus-${prefixes.sqlserverprefix}1'
param pAdministratorLogin = 'sqladminuser'

param pKeyVaultName='${prefixes.projectPrefix}-dev-${prefixes.keyvaultprefix}-dev'
