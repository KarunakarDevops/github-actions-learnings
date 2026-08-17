targetScope = 'subscription'

param pStorageAccountName string
param pResourceGroupName string


module storageAccount '10.Storageaccount.bicep' = {
  name: 'StorageAccount_module'
  scope: resourceGroup(pResourceGroupName)
  params: {
    pStorageAccountName: pStorageAccountName
  }
}
