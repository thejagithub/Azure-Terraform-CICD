# ☁️ Azure Multi-Environment Infrastructure with Terraform & Jenkins CI/CD

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)
![Microsoft Azure](https://img.shields.io/badge/Microsoft%20Azure-0078D4?logo=microsoftazure&logoColor=white)
![Azure VMSS](https://img.shields.io/badge/Azure%20VMSS-0078D4?logo=microsoftazure&logoColor=white)
![Application Gateway](https://img.shields.io/badge/Application%20Gateway-0078D4?logo=microsoftazure&logoColor=white)
![Azure Container Registry](https://img.shields.io/badge/Azure%20Container%20Registry-0078D4?logo=microsoftazure&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?logo=jenkins&logoColor=white)
![Go](https://img.shields.io/badge/Go-00ADD8?logo=go&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)
![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)
![HCL](https://img.shields.io/badge/Config-HCL-844FBA)
![License](https://img.shields.io/badge/license-MIT-blue)
![Status](https://img.shields.io/badge/status-Active-brightgreen)

This project provisions a complete multi-environment Microsoft Azure infrastructure using Terraform (Infrastructure as Code) to deploy a Dockerized monolithic application on Azure Virtual Machine Scale Sets. Infrastructure is split across Development, Shared, and Production environments using reusable Terraform modules, with a privately hosted Jenkins server driving environment-specific CI/CD pipelines.

## ⚙️ Tech Stack

| Layer | Tool / Technology |
|---|---|
| Application | Dockerized HelloWorld (monolithic) |
| IaC | Terraform (module-based) |
| Cloud Provider | Microsoft Azure |
| Compute | Azure Virtual Machine Scale Sets (VMSS) |
| Load Balancing | Azure Application Gateway |
| Image Registry | Azure Container Registry (ACR) |
| Containerization | Docker |
| CI/CD | Jenkins (declarative pipelines) |
| Networking | VNet, public/private subnets, NAT Gateway, VNet Peering |
| Access Control | VPN server, Network Security Groups, Azure RBAC |
| State Management | Azure Storage remote backend |
| Version Control | Git / GitHub |

## 📁 Project Structure

```
azure-terraform-infra/
├── environments/
│   ├── development/
│   │   ├── development-resource-group.tf
│   │   ├── development-vnet.tf
│   │   ├── development-vnet-peering.tf
│   │   ├── development-nat-gateway.tf
│   │   ├── development-agw.tf              # Application Gateway
│   │   ├── development-vmss.tf
│   │   ├── development-acr.tf
│   │   ├── development-role-assignment.tf  # RBAC (VMSS → ACR pull)
│   │   ├── providers.tf
│   │   ├── remote-state.tf                 # Backend configuration
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── production/
│   └── shared/
├── modules/
│   ├── acr/
│   ├── app-gateway/
│   ├── nat-gateway/
│   ├── vm/
│   ├── vmss/
│   └── vnet/
├── jenkins/
│   ├── Jenkinsfile.dev
│   └── Jenkinsfile.prod
└── README.md
```

Each environment directory composes the shared modules into a complete environment. Resource definitions are split into separate files by component rather than a single `main.tf`, keeping each concern independently readable. Backend configuration lives in `remote-state.tf` so every environment maintains its own isolated state.

## 🏗️ Architecture

```
                        Internet
                            │
                            ▼
              ┌─────────────────────────┐
              │  Application Gateway    │  (public subnet)
              └─────────────────────────┘
                            │
                            ▼
              ┌─────────────────────────┐
              │  VMSS — Dockerized App  │  (private subnet)
              └─────────────────────────┘
                            │
                            ▼
                    NAT Gateway (egress only)


        DEVELOPMENT VNet         SHARED VNet          PRODUCTION VNet
     ┌───────────────────┐  ┌──────────────────┐  ┌───────────────────┐
     │  App Gateway      │  │  VPN (public)    │  │  App Gateway      │
     │  VMSS (private)   │◄─┤  Jenkins(private)├─►│  VMSS (private)   │
     │  ACR              │  │                  │  │  ACR              │
     │  NAT Gateway      │  │                  │  │  NAT Gateway      │
     └───────────────────┘  └──────────────────┘  └───────────────────┘
              peering                │                  peering
                                     ▲
                                     │ authenticated VPN access only
                                     │
                                Engineer
```

## 🌐 Environment Design

Three isolated environments, each with its own resource group, VNet, and Terraform state file:

| Environment | Purpose | Contains |
|---|---|---|
| **Development** | Feature testing and integration | VNet, App Gateway, VMSS, ACR, NAT Gateway |
| **Shared** | Central control plane | Jenkins, VPN server |
| **Production** | Live workload | VNet, App Gateway, VMSS, ACR, NAT Gateway |

Shared is peered to both Development and Production, allowing Jenkins to reach deployment targets in each. Development and Production are **not** peered to each other — there is no lateral network path between them.

## 🧱 Infrastructure Components

### 1. Resource Groups
Each environment is provisioned into its own resource group, giving a clean lifecycle and permission boundary per environment.

### 2. Virtual Network & Subnets
Each VNet is segmented into public and private subnets. The Application Gateway and VPN server sit in public subnets. VMSS instances, Jenkins, and all application workloads sit in private subnets with no public IPs.

### 3. NAT Gateway
Provides outbound internet access for private subnet resources — package installs, image pulls, OS updates — without exposing them to inbound traffic.

### 4. VNet Peering
Connects the Shared environment to both Development and Production, allowing Jenkins to deploy over the Azure backbone rather than the public internet.

### 5. Azure Container Registry (ACR)
Each deployable environment has its own private registry hosting the Dockerized application image. VMSS instances authenticate and pull from ACR at boot.

### 6. Role Assignments (RBAC)
VMSS is granted the `AcrPull` role on its environment's registry via managed identity. No registry username or password is stored on instances or in Terraform variables.

### 7. Virtual Machine Scale Set (VMSS)
Hosts the Dockerized monolithic application across multiple instances. Custom data provisions Docker and pulls the application image on instance boot, so scale-out events produce ready-to-serve instances with no manual intervention.

### 8. Application Gateway
Layer 7 load balancer fronting the VMSS backend pool. Handles request routing and health probes, and is the only public entry point to the application tier.

### 9. Jenkins Server
Deployed on an Azure VM in a private subnet within the Shared environment, configured with the required plugins and declarative pipeline definitions. Never exposed to the public internet.

### 10. VPN Server
Deployed in the public subnet of the Shared environment. Engineers authenticate to the VPN to reach the privately hosted Jenkins server — the CI/CD control plane has no public attack surface.

### 11. Remote State Backend
Terraform state is stored remotely in Azure Storage rather than locally, enabling state locking and safe collaboration. Each environment uses a separate state file.

## 🔄 CI/CD Pipelines

Two separate declarative Jenkins pipelines, one per deployable environment:

**Development pipeline**
1. Checkout source from Git
2. Build Docker image
3. Tag with build number and push to Development ACR
4. Trigger VMSS rolling update in the Development environment

**Production pipeline**
1. Checkout source from Git
2. Build Docker image
3. Tag with build number and push to Production ACR
4. Manual approval gate
5. Trigger VMSS rolling update in the Production environment

Separate pipelines keep Development and Production credentials, targets, and approval requirements fully isolated — a Development build cannot reach Production.

## ✅ Prerequisites

- Azure subscription with Contributor access
- Terraform 1.5+ installed
- Azure CLI installed and authenticated (`az login`)
- Docker installed locally for image testing
- Service principal or managed identity for Terraform authentication
- Azure Storage account and container provisioned for the remote state backend
- SSH key pair for VM access over the VPN

## 🚀 Deployment

```bash
# Deploy the shared environment first (Jenkins, VPN)
cd environments/shared
terraform init
terraform plan
terraform apply

# Then deploy development and production
cd ../development
terraform init && terraform apply

cd ../production
terraform init && terraform apply
```

Shared must be applied first — the peering configurations in Development and Production reference its VNet.

## 🔐 Security Design Decisions

- **No public IPs on application infrastructure** — VMSS instances and Jenkins run in private subnets. Only the Application Gateway and VPN server are publicly reachable.
- **VPN-gated CI/CD control plane** — Jenkins holds deployment credentials for every environment. Placing it behind a VPN means a compromised Jenkins login is not sufficient on its own; network access must be established first.
- **Managed identity over stored credentials** — VMSS pulls from ACR using an `AcrPull` role assignment, so no registry credentials exist on disk or in configuration.
- **Egress-only internet via NAT Gateway** — Private resources reach the internet outbound but cannot be reached inbound.
- **Controlled peering topology** — Development and Production each connect to Shared but not to each other, reducing lateral movement risk between environments.
- **Private image registry per environment** — Images are pulled from ACR over private networking, never from a public registry at deploy time.
- **Environment-isolated Terraform state** — Each environment maintains its own remote state file, so a Development apply cannot modify Production resources.
- **Network Security Groups** — Subnet-level rules restrict traffic to the minimum required paths between tiers.

## 📸 Screenshots
