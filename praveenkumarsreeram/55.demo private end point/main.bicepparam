using './main.bicep'

param location = 'centalindia'

param vnetName = 'vnet-sql-demo'

param sqlServerName = 'sql-demo-123456789'

param databaseName = 'sqldb-demo'

param sqlAdministratorLogin = 'sqladmin'

param sqlAdministratorLoginPassword = 'ChangeThisToARealStrongPassword!123'

param privateEndpointName = 'pe-sql'

param privateDnsZoneName = 'privatelink.database.windows.net'

// Windows VM

param vmName = 'vm-windows-01'

param vmAdminUsername = 'azureadmin'

param vmAdminPassword = 'Use-Another-Secure-Password-Here'

param rdpSourceAddressPrefix = '0.0.0.0/0'

param vmSize = 'Standard_B2s'
