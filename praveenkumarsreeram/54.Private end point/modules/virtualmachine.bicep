@description('Location of the VM.')
param location string

@description('Name of the Windows VM.')
param vmName string

@description('Subnet ID where the VM will be deployed.')
param subnetId string

@description('VM administrator username.')
param adminUsername string

@secure()
@description('VM administrator password.')
param adminPassword string

@description('CIDR range allowed to connect to RDP.')
param rdpSourceAddressPrefix string

@description('VM size.')
param vmSize string = 'Standard_B2s'


// ------------------------------------------------------------
// Network Security Group
// ------------------------------------------------------------

resource vmNsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: '${vmName}-nsg'
  location: location

  properties: {
    securityRules: [
      {
        name: 'Allow-RDP'
        properties: {
          priority: 100

          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'

          sourcePortRange: '*'
          destinationPortRange: '3389'

          sourceAddressPrefix:'*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}


// ------------------------------------------------------------
// Public IP
// ------------------------------------------------------------

resource publicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${vmName}-pip'
  location: location

  sku: {
    name: 'Standard'
  }

  properties: {
    publicIPAllocationMethod: 'Static'
  }
}


// ------------------------------------------------------------
// Network Interface
// ------------------------------------------------------------

resource nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: '${vmName}-nic'
  location: location

  properties: {
    networkSecurityGroup: {
      id: vmNsg.id
    }

    ipConfigurations: [
      {
        name: 'ipconfig1'

        properties: {
          privateIPAllocationMethod: 'Dynamic'

          subnet: {
            id: subnetId
          }

          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
}


// ------------------------------------------------------------
// Windows Virtual Machine
// ------------------------------------------------------------

resource vm 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: vmName
  location: location

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVMAgent: true
      }
    }

    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-azure-edition'
        version: 'latest'
      }

      osDisk: {
        createOption: 'FromImage'

        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}


// ------------------------------------------------------------
// Outputs
// ------------------------------------------------------------

output vmId string = vm.id

output vmName string = vm.name

output nicId string = nic.id

output privateIpAddress string = nic.properties.ipConfigurations[0].properties.privateIPAddress

output publicIpAddress string = publicIp.properties.ipAddress
