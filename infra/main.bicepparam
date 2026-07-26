using './main.bicep'

param location = 'westus3'
param namePrefix = 'pcdb'
param environment = 'dev' // The environment of the web app

param storageName = 'space' // The name of the storage account
param storageSku = 'Standard_LRS' // The SKU of the storage account

param appServicePlanSku = 'B1' // The SKU of App Service Plan

param linuxFxVersion  = 'DOCKER|${dockerImage}:${dockerImageTag}' // The runtime stack of web app
var dockerImage  = 'nginx' 
var dockerImageTag  = 'latest'


param groupName = 'rg' // The name of the resource group
