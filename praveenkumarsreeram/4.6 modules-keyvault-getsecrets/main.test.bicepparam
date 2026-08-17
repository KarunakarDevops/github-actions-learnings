using './main.bicep'

param pResourceGroupName = 'azbicepresourcegroup'
param pResourcegroupLocation = 'centralindia'

param pAppServicePlanName = 'azbicep-test-eus-asp1'
param pWebAppName = 'azbicep-test-eus-webapp1'
param pAppInsightsName = 'azbicep-test-eus-webapp1-ai'
param pLogAnalyticsWorkspaceName = 'azbicep-test-eus-webapp1-law1'

param pAdministratorLogin = 'sqladminuser'
param pSqlServerName = 'azbicep-test-eus-sqlserver1'

param pKeyVaultName='azbicep-test-eus-kv1'
