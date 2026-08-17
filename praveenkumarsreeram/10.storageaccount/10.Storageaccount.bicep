param pStorageAccountName string = 'azbicepdevstorageaccount1'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: pStorageAccountName
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

output oStorageAccountId string = storageAccount.id

