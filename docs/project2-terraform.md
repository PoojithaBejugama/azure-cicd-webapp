# Project 2: Infrastructure as Code with Terraform on Azure

## Industry Context
Managing cloud resources manually does not scale well. Teams need infrastructure definitions in version control so environments can be recreated consistently.

## Business Problem
Without Infrastructure as Code, resource configuration drifts over time and development, staging, and production environments become difficult to manage consistently.

## Objective
Use Terraform to provision reusable Azure infrastructure across multiple environments from a single codebase.

## Implementation
- Built a modular Terraform structure under `infra/`
- Created reusable modules for:
  - Resource Group
  - App Service Plan and Linux Web App
  - Application Insights
  - Azure Container Registry
- Created separate root modules for:
  - `infra/env/dev`
  - `infra/env/staging`
  - `infra/env/prod`
- Used environment-specific `terraform.tfvars` files to control:
  - Azure region
  - environment name
  - resource prefix
  - App Service SKU
  - Node.js version
  - common tags
- Implemented consistent naming such as:
  - `rg-dev-pooja-demo`
  - `asp-dev-pooja-demo`
  - `webapp-pooja-dev-demo`
  - `appi-dev-pooja-demo`
- Exposed useful Terraform outputs including:
  - web app URL
  - resource group name
  - Application Insights name
  - ACR login server

## Architecture
Terraform Root Module -> Reusable Child Modules -> Azure Resources (Resource Group, App Service, Application Insights, ACR)

## Tools Used
- Terraform
- AzureRM Provider
- Azure CLI

## Proof (Screenshots)
- [ ] `infra/modules/` folder structure
- [ ] `infra/env/dev` plan output
- [ ] `terraform apply` success for dev
- [ ] Terraform outputs showing web app URL and ACR details
- [ ] Azure portal view of deployed resources

## Key Learnings
- Learned how to separate Terraform root modules from reusable child modules
- Practiced multi-environment infrastructure design with dev, staging, and prod folders
- Used variables, outputs, and tags to keep the infrastructure reusable and maintainable
- Understood how Terraform can provision both application hosting and supporting platform services
