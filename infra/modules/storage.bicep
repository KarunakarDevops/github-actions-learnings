@minLength(4)
@maxLength(24)
@description('The name of the storage account. Must be between 4 and 24 characters, and can only contain lowercase letters and numbers.')
param storageName string

@description('The location of the storage account.')
param location string 

@description('The SKU of the storage account.')
param skuName string = 'Standard_LRS' // The SKU of the storage account

@allowed([
  'dev'
  'test'
  'prod'
])
@description('The environment of the storage account.')
param environment string = 'dev' // The environment of the storage account

@description('The prefix for the storage account name.')
param namePrefix string  // The prefix for the storage account name

var storageAccountName = toLower('storage${namePrefix}${storageName}${environment}')

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
