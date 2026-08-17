param pKeyVaultName string
param pLocation string = resourceGroup().location

param pAccesPolicies array = [
  {
    objectId: 'd0052627-c22c-4ddf-99a4-a7388a69ac9e'
  }
  {
    objectId: 'b12c10cc-9c4b-4b23-bd8a-718cbdf2b212'
  }
]
resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: pKeyVaultName
  location: pLocation
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: 'd0052627-c22c-4ddf-99a4-a7388a69ac9e'
        permissions: {
          keys: [
            'list'
            'get'
          ]
          secrets: [
            'list'
            'get'
            'set'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource keyVaultAccessPolicies 'Microsoft.KeyVault/vaults/accessPolicies@2023-07-01' = {
  name: 'add'
  parent: keyVault
  properties: {
    accessPolicies: [
      for accessPolicy in pAccesPolicies: {
        tenantId: subscription().tenantId
        objectId: accessPolicy.objectId
        permissions: {
          secrets: [
            'list'
            'get'
            'set'
          ]
        }
      }
    ]
  }
}
resource keyVaultKey 'Microsoft.KeyVault/vaults/keys@2019-09-01' = {
  name: 'key1'
  parent: keyVault
  properties: {
    kty: 'RSA'
    keySize: 2048
    curveName: 'P-256'
  }
}

resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: 'sqladminpassword'
  parent: keyVault
  properties: {
    value: 'P@ssw0rd1234'
  }
}
