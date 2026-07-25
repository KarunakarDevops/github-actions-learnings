- Install required extensions to work with git actions
    - GitHub Actions

-- publish web app to azure
  - Create new in git. go to Secrets and Variables-> Actions -> new repository secret ->Name(AZURE_WEBAPP_PUBLISH_PROFILE) -> Content should be the publish profile


-- Create service principle
Prerequisites: Create a Service Principal:

az ad sp create-for-rbac --name spn-azure-bicep-github --role contributor --scopes /subscriptions/<SUBSCRIPTION_ID> --sdk-auth
---------
output:
---------
{
  "clientId": "227271a6-xxx",
  "clientSecret": "Aw8l8Rxxx",
  "subscriptionId": "17b12858-xxx",
  "tenantId": "558506eb-xxx",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
More resources:
https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions?tabs=CLI

-- Crate New repository secret with name AZURE_CREDENTIALS and content should be the above json generated when we a Service Principal


- Oidc connection between azure and github

  - Repo: https://github.com/KarunakarDevops/github-actions-learnings
  - How to Get- organisation id:
      https://api.github.com/users/KarunakarDevops
      - 277266738
  - How to Get repo id:
      https://api.github.com/repos/KarunakarDevops/github-actions-learnings
    - 1305684746

- 1. Create app registration
- 2. Create Federated credentials
    - Federated credential scenario:GitHub Actions deploying Azure resources 
    - Organization: KarunakarDevops
    - Organization ID: 277266738
    - Repository : github-actions-learnings
    - Repository ID : 1305684746
    - Entity typ : branch
    - Based on selection : main
- 3. Credential details
      Name: github-workflow-oidc-demo

- 4. Create new repository secrets in git hub settigns
    - AZURE_CLIENT_ID
    - AZURE_SUBSCRIPTION_ID
    - AZURE_TENANT_ID

-- Houssem Dellai
https://github.com/HoussemDellai/github-actions-course/blob/main/.github/workflows/040-github-linter.yml