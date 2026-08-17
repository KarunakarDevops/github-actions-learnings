using './main.bicep'

param pResourceGroupName = 'azbicepresourcegroup'
param pResourcegroupLocation = 'centralindia'

param pAppServicePlanName = 'azbicep-prod-eus-asp1'
param pWebAppName = 'azbicep-prod-eus-webapp1'
param pAppInsightsName = 'azbicep-prod-eus-webapp1-ai'
param pLogAnalyticsWorkspaceName = 'azbicep-prod-eus-webapp1-law1'

param pAdministratorLogin = 'sqladminuser'
param pSqlServerName = 'azbicep-prod-eus-sqlserver1'

param pKeyVaultName='demokeyvault-sde'
