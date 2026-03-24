# ============================================
# HOW TO USE .env FILES
# ============================================

## Overview
The `.env*` files store sensitive configuration and secrets that should NEVER be committed to git.

## Files

- `.env.example` - Template (safe to commit, shows structure)
- `.env.dev` - Development secrets (DO NOT COMMIT)
- `.env.staging` - Staging secrets (DO NOT COMMIT)
- `.env.prod` - Production secrets (DO NOT COMMIT)

All are in `.gitignore` for safety.

## Setup Instructions

### Step 1: Get Your Subscription IDs

Get your Azure subscription ID and tenant ID:
```bash
az login
az account show  # Copy subscription "id" and "tenantId"
```

### Step 2: Fill in .env Files

Edit each `.env*` file with your values:

**`.env.dev`:**
```
SUBSCRIPTION_ID=your-actual-dev-subscription-id
TENANT_ID=your-actual-dev-tenant-id
```

**`.env.staging`:**
```
SUBSCRIPTION_ID=your-actual-staging-subscription-id
TENANT_ID=your-actual-staging-tenant-id
```

**`.env.prod`:**
```
SUBSCRIPTION_ID=your-actual-prod-subscription-id
TENANT_ID=your-actual-prod-tenant-id
```

### Step 3: Load Environment Variables Before Terraform

#### Option A: PowerShell (Windows)
```bash
cd infra\env\dev

# Load .env file
$envFile = '..\.env.dev'
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^\s*(.+?)\s*=\s*(.*)$') {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2])
        }
    }
}

# Verify loaded
$env:SUBSCRIPTION_ID

# Now run Terraform
terraform plan
```

#### Option B: Bash/Linux/Mac
```bash
cd infra/env/dev

# Load .env file
export $(cat ../../.env.dev | xargs)

# Verify loaded
echo $SUBSCRIPTION_ID

# Now run Terraform
terraform plan
```

#### Option C: Use a Script
Create `load-env.ps1`:
```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$Environment
)

$envFile = ".env.$Environment"
if (!(Test-Path $envFile)) {
    Write-Error "File $envFile not found"
    exit 1
}

Write-Host "Loading environment variables from $envFile..."
Get-Content $envFile | ForEach-Object {
    if ($_ -match '^\s*(.+?)\s*=\s*(.*)$' -and $_ -notlike '#*') {
        $name = $matches[1].Trim()
        $value = $matches[2].Trim()
        [System.Environment]::SetEnvironmentVariable($name, $value)
        Write-Host "  $name = ****" (if secrets then show *****)
    }
}

Write-Host "Environment variables loaded. Running Terraform init..."
terraform init
```

Usage:
```bash
cd infra/env/dev
..\..\load-env.ps1 -Environment dev
```

## Terraform Integration

### Using Environment Variables in Terraform

In your `variables.tf`, you can reference environment variables:

```hcl
variable "subscription_id" {
  type    = string
  default = ""
}

variable "tenant_id" {
  type    = string
  default = ""
}
```

Load them and pass to Terraform:
```bash
# Load from .env file first
terraform apply \
  -var="subscription_id=$env:SUBSCRIPTION_ID" \
  -var="tenant_id=$env:TENANT_ID"
```

Or use `-var-file`:
```bash
terraform apply -var-file="dev.tfvars"
```

## What Goes in .env Files

### Secrets (ALWAYS use .env):
- Subscription IDs
- Tenant IDs
- Client IDs / Client Secrets
- API Keys
- Database passwords
- Access tokens

### Configuration (Can use .env OR terraform.tfvars):
- Environment name
- Resource prefix
- Azure region
- SKU tier
- Node version

## Best Practices

1. **Never commit .env files:**
   ```bash
   git add .
   # .env.dev, .env.staging, .env.prod are excluded by .gitignore
   ```

2. **Share .env.example with team:**
   ```bash
   git add .env.example  # Safe - contains no secrets
   ```

3. **For CI/CD pipelines (Azure Pipelines):**
   Store secrets in Azure Pipelines Variable Groups, not .env files:
   ```yaml
   variables:
     - group: terraform-secrets-dev
   
   steps:
     - script: |
         terraform init
         terraform apply -var="subscription_id=$(SUBSCRIPTION_ID)"
   ```

4. **For local development:**
   Load .env files before each Terraform command:
   ```bash
   . load-env.sh dev
   terraform plan
   ```

## Example Workflow

```bash
# Development
cd infra/env/dev
. ../../load-env.sh dev  # Loads .env.dev
terraform init
terraform plan
terraform apply

# Later, if you switch to staging
cd ../staging
. ../../load-env.sh staging  # Loads .env.staging
terraform init
terraform plan
terraform apply
```

## Troubleshooting

### "subscription_id is empty"
```bash
# Check if variable is loaded
echo $SUBSCRIPTION_ID  (PowerShell: $env:SUBSCRIPTION_ID)

# If empty, reload .env file
```

### "Permission denied to read .env"
```bash
# Make sure .env files are readable
chmod 600 .env*  (Linux/Mac)
```

### ".env file not found"
```bash
# Make sure you're in the right directory
pwd  # Should be in infra/env/dev (or similar)
# .env files are at infra/.env.dev
```

## Security Notes

- `.env files are in `.gitignore` - cannot be accidentally committed
- Permission: Make `.env` files readable only by you: `chmod 600 .env*`
- Rotate secrets periodically
- Use Azure Managed Identities when possible (reduces need for secrets)
