                         Azure
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  Resource Group                                             │
│                                                             │
│  ┌──────────────────── VNet ────────────────────────────┐   │
│  │                                                      │   │
│  │  ┌──────────────────┐    ┌────────────────────────┐  │   │
│  │  │ snet-app         │    │ snet-sql               │  │   │
│  │  │                  │    │                        │  │   │
│  │  │ Private Endpoint │    │  Private Endpoint      │  │   │
│  │  │        |         │    │       │                │  │   │
│  │  └────────|─────────┘    └───────┼────────────────┘  │   │
│  │           |                      │                   │   │
│  └───────────|──────────────────────┼──────────────────┘    │
│              |                      │                       │
│              ▼                      ▼                       │
│           Web App            Azure SQL Server               │
│                                     │                       │
│                                     ▼                       │
│                              SQL Database                   │
│                                                             │
│  Private DNS Zone:                                          │
│  privatelink.database.windows.net                           | 
|  privatelink.websites.windows.net                           │
│                                                             │
└─────────────────────────────────────────────────────────────┘

For Azure SQL, the Private Endpoint uses the sqlServer group ID, and the recommended private DNS zone is privatelink.database.windows.net. Microsoft also recommends linking the private DNS zone to the VNet

1. Project structure
azure-sql-private/
│
├── main.bicep
├── main.bicepparam
│
└── modules/
    ├── vnet.bicep
    ├── sql-server.bicep
    ├── sql-database.bicep
    ├── private-dns-zone.bicep
    └── private-endpoint.bicep
The important learning point is that each module has one responsibility.

For example:

vnet.bicep → VNet + subnets
sql-server.bicep → SQL logical server
sql-database.bicep → SQL database
private-dns-zone.bicep → Private DNS zone + VNet link
private-endpoint.bicep → Private Endpoint + DNS zone group
main.bicep → orchestrates everything
Microsoft's Bicep Private Endpoint example follows the same basic architecture, including the Private Endpoint, DNS zone, VNet link, and private DNS zone group.

2. modules/vnet.bicep
We'll create:

VNet: vnet-app
Application subnet: snet-app
SQL Private Endpoint subnet: snet-sql

5.Create the Private DNS zone and link it to the VNet.
The DNS zone is:

privatelink.database.windows.net

This is important because Azure SQL's normal hostname looks like:

myserver.database.windows.net

With Private Link, DNS ultimately resolves the SQL hostname through the private-link namespace to the Private Endpoint's private IP. Microsoft documents this DNS behavior for Private Endpoints.

6.private-endpoint.bicep

There are two concepts to understand here.

Private Link connection
privateLinkServiceId: sqlServerId

groupIds: [
  'sqlServer'
]

This says:

Create a Private Endpoint to the Azure SQL logical server.

Microsoft's SQL Private Endpoint example uses the sqlServer target subresource. 
M
Microsoft Learn
+1

Private DNS zone group
This:

privateDnsZoneGroup

connects the Private Endpoint to:

privatelink.database.windows.net

This is an important distinction:

Private Endpoint
       │
       ├── Private Link connection → SQL Server
       │
       └── Private DNS Zone Group → Private DNS Zone

The Private DNS zone group is what allows Azure to maintain the DNS relationship for the Private Endpoint.

- Then validate:
az group create --name rg-bicep-sql-demo --location eastus

- Then validate:
az deployment group validate --resource-group rg-bicep-sql-demo --template-file main.bicep --parameters main.bicepparam

- Then preview the deployment:
az deployment group what-if --resource-group rg-bicep-sql-demo --template-file main.bicep --parameters main.bicepparam

- Deploy the file
az deployment group create --resource-group rg-bicep-sql-demo --template-file main.bicep --parameters main.bicepparam

10. Understand the dependency graph

Conceptually, your deployment becomes:

                    ┌───────────────┐
                    │     VNet      │
                    └───────┬───────┘
                            │
                  ┌─────────┴─────────┐
                  │                   │
                  ▼                   ▼
             snet-app             snet-sql
                                      │
                                      │
                                      ▼
                              Private Endpoint
                                      ▲
                                      │
                    ┌─────────────────┴──────────────┐
                    │                                │
                    │                                │
                    ▼                                ▼
              SQL Server                       Private DNS
                    │                                │
                    ▼                                │
              SQL Database                          │
                                                     │
                                                     ▼
                                      VNet ↔ Private DNS Link

The important relationships are:
SQL Database
     │
     └── depends on SQL Server

Private DNS
     │
     └── depends on VNet

Private Endpoint
     │
     ├── depends on VNet
     ├── depends on SQL Server
     └── depends on Private DNS


11. What gets created?

rg-bicep-sql-demo
│
├── vnet-sql-demo
│   │
│   ├── snet-app
│   │
│   └── snet-sql
│
├── sql-demo-123456789
│   │
│   └── sqldb-demo
│
├── pe-sql
│
└── privatelink.database.windows.net
    │
    └── vnet-sql-link

12. Why don't we create a DNS A record ourselves?
This is an excellent Bicep/Azure question.

You might initially think you need:

Private DNS Zone
       │
       └── A record
             │
             └── sql-demo-123456789 → 10.0.2.4

But with the Private Endpoint DNS zone group:

resource privateDnsZoneGroup ...

Azure manages the appropriate private DNS record associated with the Private Endpoint.

Microsoft's architecture uses the Private DNS zone together with the Private Endpoint's DNS zone group for this scenario. 
M
Microsoft Learn
+1

So we intentionally don't hard-code the private IP address.

That's much better because Azure controls the Private Endpoint's IP allocation.


13. One improvement I'd make for a production version
For learning, the structure above is great.

For production, I'd probably evolve it into:

infra/
│
├── main.bicep
├── main.bicepparam
│
├── modules/
│   ├── network/
│   │   └── vnet.bicep
│   │
│   ├── sql/
│   │   ├── server.bicep
│   │   └── database.bicep
│   │
│   ├── private-endpoint/
│   │   └── private-endpoint.bicep
│   │
│   └── private-dns/
│       └── private-dns-zone.bicep
│
└── README.md

And I'd introduce:

Azure Key Vault for secrets
Managed identities
Azure RBAC
Diagnostic settings
SQL auditing
Defender for SQL
Resource locks where appropriate
Tags
Azure Policy
parameterized SKUs
environment-specific .bicepparam files
CI/CD deployment through GitHub Actions or Azure DevOps


14. A useful learning exercise
Rather than just copying the complete solution, I'd recommend building it in this order:

1. Create only the VNet

    . vnet.bicep
    . snet-app
    . snet-sql

2. Create the SQL server

    . sql-server.bicep

3. Create the database

    Learn parent/child resources.

4. Create the Private DNS zone

    Learn Microsoft.Network/privateDnsZones.

5. Create the VNet link

Learn resource dependencies and IDs.

6. Create the Private Endpoint

Learn privateLinkServiceConnections.

7. Add the DNS zone group

Learn nested resources.

8. Connect everything from main.bicep

Learn module inputs and outputs.

9. Run what-if

Learn how Bicep translates into an ARM deployment.

10. Deploy and test DNS

From a VM inside the VNet, nslookup <sql-server>.database.windows.net should ultimately resolve to the Private Endpoint's private IP. Microsoft uses this as a validation step in its SQL Private Endpoint tutorial.

- Create modules/windows-vm.bicep
This module creates:

NSG
Public IP
NIC
Windows VM
RDP rule
Associates NSG with NIC

- Azure architecture:
Internet
   │
   │ TCP 3389
   ▼
Public IP
   │
   ▼
NIC
   │
   ├── NSG
   │     └── Allow RDP
   │
   ▼
Windows VM
   │
   ▼
snet-app
   │
   ▼
VNet

Azure architecture:
azure-sql-private/
│
├── main.bicep
├── main.bicepparam
│
└── modules/
    │
    ├── vnet.bicep
    │
    ├── sql-server.bicep
    │
    ├── sql-database.bicep
    │
    ├── private-dns-zone.bicep
    │
    ├── private-endpoint.bicep
    │
    └── windows-vm.bicep

Resource Group
│
├── VNet
│   │
│   ├── snet-app
│   │     │
│   │     └── Windows VM
│   │           │
│   │           ├── NIC
│   │           ├── Public IP
│   │           └── NSG
│   │                │
│   │                └── TCP 3389
│   │
│   └── snet-sql
│         │
│         └── Private Endpoint
│
├── SQL Server
│   │
│   └── SQL Database
│
└── Private DNS Zone
       │
       └── VNet Link
