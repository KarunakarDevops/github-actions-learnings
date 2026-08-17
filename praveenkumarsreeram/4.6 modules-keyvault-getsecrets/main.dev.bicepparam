using './main.bicep'

param pResourceGroupName = 'azbicepresourcegroup'
param pResourcegroupLocation = 'centralindia'

param pAppServicePlanName = 'azbicep-dev-eus-asp1'
param pWebAppName = 'azbicep-dev-eus-webapp1'
param pAppInsightsName = 'azbicep-dev-eus-webapp1-ai'
param pLogAnalyticsWorkspaceName = 'azbicep-dev-eus-webapp1-law1'

param pSqlServerName = 'azbicep-dev-eus-sqlserver1'
param pAdministratorLogin = 'sqladminuser'

param pKeyVaultName='demokeyvault-sde-dev'
