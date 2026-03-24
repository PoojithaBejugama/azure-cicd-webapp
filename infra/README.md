# Terraform Multi-Environment Infrastructure

This project demonstrates a professional, scalable Terraform structure for managing infrastructure across multiple environments (dev, staging, prod) within a single `infra/` folder.

## New Project Structure

```
infra/
├── modules/                              # Reusable infrastructure modules
│   ├── resource_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── app_service/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── application_insights/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── env/                                  # Environment-specific root modules
│   ├── dev/
│   │   ├── provider.tf                  # Azure provider (ONLY in root modules)
│   │   ├── main.tf                      # Instantiates all modules
│   │   ├── variables.tf                 # Input variable definitions
│   │   ├── terraform.tfvars             # Dev-specific values
│   │   └── outputs.tf                   # Root module outputs
│   ├── staging/
│   │   ├── provider.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── outputs.tf
│   └── prod/
│       ├── provider.tf
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── outputs.tf
│
├── provider.tf                           # OLD - Can be deleted
├── main.tf                               # OLD - Can be deleted
├── variables.tf                          # OLD - Can be deleted
├── modules/ (old app_service)           # OLD - Can be deleted
└── README.md                             # This file

```

## Design Principles

### 1. Provider Configuration in Root Modules Only
- **Azure provider** is ONLY in `env/*/provider.tf`
- **Child modules** (`modules/*`) have NO provider declarations
- This makes modules completely environment-agnostic and reusable

### 2. Three Reusable Child Modules
- `modules/resource_group/` - Creates Azure Resource Group
- `modules/app_service/` - Creates App Service Plan + Linux Web App
- `modules/application_insights/` - Creates Application Insights

Each module is portable, documented, and has clear inputs/outputs.

### 3. Three Environment Root Modules
- `env/dev/` - Development environment (B1 SKU)
- `env/staging/` - Staging environment (B2 SKU)
- `env/prod/` - Production environment (S1 SKU)

Each environment:
- Has its own state file (separate `.tfstate`)
- Uses the same child modules
- Has environment-specific variable values
- Has its own provider configuration

### 4. Naming Convention
All resources follow the pattern: `{type}-{environment}-{prefix}-demo`

Examples:
- `rg-dev-pooja-demo` (resource group)
- `asp-dev-pooja-demo` (app service plan)
- `webapp-pooja-dev-demo` (web app)
- `appi-dev-pooja-demo` (application insights)

## Resource Addressing & State Migration ⚠️

### What Changed
Your existing resources will be **recreated** because:
1. Old structure: `azurerm_resource_group.rg` in root
2. New structure: `module.resource_group.azurerm_resource_group.rg` (inside module)

The resource address changed, so Terraform sees it as a different resource.

### Migration Options

#### Option A: Destroy and Rebuild (Simplest for Dev)
```bash
# Clean up old resources
cd infra
terraform destroy -auto-approve

# Deploy new structure
cd inf/env/dev
terraform init
terraform apply
```
**Pros:** Clean slate, no state migration headaches
**Cons:** Resources are recreated (brief downtime)

#### Option B: State Import (Preserves Resources)
If you want to keep existing resources and import them into the new structure:

```bash
# Navigate to dev environment
cd infra/env/dev
terraform init

# Rename old resource to match module structure
# Old: azurerm_resource_group.rg
# New: module.resource_group.azurerm_resource_group.rg
# This is complex and error-prone - not recommended unless resources are critical

# Instead, delete old tfstate and start fresh
```

**Recommendation:** Use **Option A** (destroy and rebuild) for the cleanest transition.

## Getting Started - Deploy Dev First

### Step 1: Prerequisites
```bash
# Verify Terraform is installed
terraform version

# Login to Azure
az login
az account show  # Verify correct subscription
```

### Step 2: Delete Old Configuration (Clean Slate)
```bash
# Remove old state if it exists
cd c:\Users\pooji\Downloads\newproejct1\project1\infra
rm terraform.tfstate terraform.tfstate.backup .terraform -r

# Destroy old resources if Azure resources exist
terraform destroy -auto-approve  # (if this was previously applied)
```

### Step 3: Deploy Development Environment
```bash
# Navigate to dev environment
cd infra\env\dev

# Initialize Terraform (download providers and modules)
terraform init

# Review what will be created
terraform plan

# Create development resources
terraform apply
```

When `terraform apply` completes, it will create:
- Resource Group: `rg-dev-pooja-demo`
- App Service Plan: `asp-dev-pooja-demo` (B1 SKU - cheap)
- Web App: `webapp-pooja-dev-demo`
- Application Insights: `appi-dev-pooja-demo`

### Step 4: View Outputs
```bash
# See deployed resource names and URLs
terraform output

# Sample output:
# application_insights_name = "appi-dev-pooja-demo"
# app_service_plan_id = "/subscriptions/.../asp-dev-pooja-demo"
# resource_group_id = "/subscriptions/.../rg-dev-pooja-demo"
# resource_group_name = "rg-dev-pooja-demo"
# webapp_url = "https://webapp-pooja-dev-demo.azurewebsites.net"
```

## Deploying Other Environments

### Staging Environment
```bash
cd infra\env\staging

terraform init
terraform plan
terraform apply  # Creates B2 SKU (more powerful than dev)
```

### Production Environment
```bash
cd infra\env\prod

terraform init
terraform plan
terraform apply  # Creates S1 SKU (optimized for production)
```

## Customizing Environment Values

### Change SKU (Compute Tier)
Edit `infra/env/dev/terraform.tfvars`:
```hcl
app_service_sku = "B2"  # Change from B1 to B2, S1, S2, etc.
```

### Change Node Version
```hcl
node_version = "20-lts"  # Change from 18-lts to 16-lts or 20-lts
```

### Change Azure Region
```hcl
location = "East US"  # Change from Canada Central
```

### Add Custom Tags
```hcl
common_tags = {
  ManagedBy   = "Terraform"
  Environment = "dev"
  Project     = "DevOps-Demo"
  CostCenter  = "Engineering"  # Add tags as needed
  Team        = "Platform"
}
```

## Project Structure Benefits for Interviews

### 1. "Multi-Environment Strategy"
*"I organized infrastructure into separate environments (dev, staging, prod) so each can be managed independently with different configurations and resources."*

### 2. "Module Reusability"
*"The resource_group, app_service, and application_insights modules are completely environment-agnostic. They accept variables and can be deployed to any environment without modification."*

### 3. "Provider at Root Level"
*"Azure provider configuration is only in the environment root modules (env/*/provider.tf). This keeps child modules portable and testable."*

### 4. "Clear Naming Conventions"
*"Resources follow a consistent naming pattern: type-environment-prefix-purpose. For example, 'rg-dev-pooja-demo', 'asp-staging-pooja-demo'. This makes resources self-documenting."*

### 5. "Separation of Concerns"
*"Configuration variables live in terraform.tfvars, resource definitions are in modules, and orchestration happens at the root level. This makes the code maintainable."*

### 6. "State Isolation"
*"Each environment has its own Terraform state file. If development breaks, it doesn't affect staging or production."*

## File Comparison: Before → After

### Before (Old)
```
infra/
├── provider.tf
├── main.tf
├── variables.tf
└── modules/app_service/
```
- ✗ All resources in one root module
- ✗ Hard to manage multiple environments
- ✗ No clear separation

### After (New)
```
infra/
├── modules/
│   ├── resource_group/
│   ├── app_service/
│   ├── application_insights/
└── env/
    ├── dev/
    ├── staging/
    └── prod/
```
- ✓ Reusable modules
- ✓ Environment-specific configurations
- ✓ Clear structure
- ✓ Easy to add new environments
- ✓ Interview-ready architecture

## Cleanup: Delete Old Files

Once you've deployed the new structure successfully, delete these old files:
```bash
cd infra

rm provider.tf          # Old provider config
rm main.tf              # Old main config
rm variables.tf         # Old variables
rm -r modules/          # Old app_service module (keep if custom)
rm terraform.tfstate*   # Old state files
rm -r .terraform/       # Old provider cache
```

## Destroying Infrastructure

### Destroy Dev Environment
```bash
cd infra\env\dev
terraform destroy  # Will prompt for confirmation

# Or skip confirmation
terraform destroy -auto-approve
```

### Destroy All Environments
```bash
# Destroy prod
cd infra\env\prod
terraform destroy -auto-approve

# Destroy staging
cd infra\env\staging
terraform destroy -auto-approve

# Destroy dev
cd infra\env\dev
terraform destroy -auto-approve
```

## State File Management

**Important:** Terraform state files contain sensitive data. Never commit them to git.

Add to `.gitignore`:
```
*.tfstate
*.tfstate.*
.terraform/
.terraform.lock.hcl
```

### Remote State (Recommended for Production)
To store state in Azure Storage Account:

Create `infra/env/dev/backend.tf`:
```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstate"
    container_name       = "dev-state"
    key                  = "terraform.tfstate"
  }
}
```

Then reinitialize:
```bash
terraform init  # Prompts to migrate state
```

## Troubleshooting

### "Resource Group already exists"
Another RG with that name already exists in your Azure subscription.
- Change `resource_prefix` in `terraform.tfvars` to something unique
- Or delete the existing RG from Azure Portal

### "Module not found" Error
Make sure you're in the correct directory:
```bash
pwd  # Should be: infra/env/dev
terraform init
```

### "Authentication failed"
```bash
az login
az account set --subscription "Your-Subscription-ID"
```

### "State mismatch" Error
If you see warnings about state resources not matching:
```bash
# Start fresh - destroy and rebuild
terraform destroy -auto-approve
terraform plan  # Should show what will be created
terraform apply
```

## Exact Commands for Dev Deployment

Copy-paste these commands in order:

```bash
# 1. Navigate to workspace
cd c:\Users\pooji\Downloads\newproejct1\project1

# 2. Remove old state (if exists)
cd infra
rm -r .terraform terraform.tfstate* 2>nul

# 3. Navigate to dev environment
cd env\dev

# 4. Initialize
terraform init

# 5. Plan
terraform plan

# 6. Apply
terraform apply
```

When prompted `Do you want to perform these actions?` → Type `yes` and press Enter.

## Next Steps

1. ✅ Deploy dev environment (start here)
2. Deploy staging environment
3. Deploy production environment
4. Set up remote state with Azure Storage
5. Integrate into CI/CD pipeline (Azure Pipelines)
6. Add more modules (databases, networking, etc.)

## Summary

You now have a professional, scalable Terraform structure that:
- Manages three environments separately
- Reuses code through modules
- Follows AWS/Azure best practices
- Is clean and interview-friendly
- Easy to explain to your team

**Start with dev first to test the structure, then deploy staging and prod!**
