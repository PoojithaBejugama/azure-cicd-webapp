# .env Files Summary

## What Are .env Files?

`.env` files store **sensitive secrets and configuration** that should **NEVER be committed to git**.

## The Files Created

### `.env.example` ✅ SAFE TO COMMIT
- Template showing the format
- Contains **NO real secrets**
- Safe for git - helps team know what variables exist
- Copy this and fill in your actual values

### `.env.dev` ❌ NEVER COMMIT
- **Your actual development secrets**
- Contains your Subscription ID, Tenant ID, etc.
- Protected by `.gitignore` - cannot be accidentally committed
- Only you and your machine have it

### `.env.staging` ❌ NEVER COMMIT
- **Staging environment secrets**
- Different Subscription/Tenant than dev
- Isolated secrets for staging only

### `.env.prod` ❌ NEVER COMMIT
- **Production environment secrets**
- Most sensitive - highest security
- Different Subscription/Tenant than dev/staging
- Isolated secrets for production only

---

## What's IN These Files?

```
SUBSCRIPTION_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx   # Azure subscription
TENANT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx         # Azure tenant/directory
ARM_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx     # Service principal app ID
ARM_CLIENT_SECRET=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx # Service principal password
ENVIRONMENT=dev                                         # Environment name
LOCATION=Canada Central                                 # Azure region
RESOURCE_PREFIX=pooja                                   # Resource naming prefix
APP_SERVICE_SKU=B1                                      # Compute tier
NODE_VERSION=18-lts                                     # Node.js version
```

---

## .gitignore Protection

Your `.gitignore` now prevents these from being committed:

```
.env
.env.dev
.env.staging
.env.prod
.env.local
*.tfstate              # Terraform state (contains secrets too!)
.terraform/            # Downloaded providers
*.key, *.pem, *.pfx   # SSL/encryption keys
.aws/, .azure/        # Cloud credentials
(+ many more sensitive files)
```

**Result:** Even if you accidentally `git add .`, these files will be ignored automatically. ✅

---

## How to Use

### Give to your team members safely:
```bash
git add .env.example
git commit -m "Add .env template"
git push
```

### Each team member then does:
```bash
cp .env.example .env.dev
# Edit .env.dev and fill in YOUR secrets
```

### Before deploying:
```bash
# Load your secrets
. .\load-env.ps1 -Environment dev

# Now run Terraform (uses loaded secrets)
cd env\dev
terraform apply
```

---

## Security Checklist

- ✅ `.env.example` → in git (no secrets)
- ✅ `.env.dev`, `.env.staging`, `.env.prod` → in `.gitignore` (never in git)
- ✅ `.gitignore` covers all secret files
- ✅ `.terraform/` (has secrets) → in `.gitignore`
- ✅ `*.tfstate` (has secrets) → in `.gitignore`

**If you ever see `git status` show `.env.dev` as "untracked but not ignored":**
```bash
# That means .gitignore isn't working - check the file
cat .gitignore | grep env

# Should see: .env, .env.dev, .env.staging, .env.prod
```

---

## TL;DR

| File | Safe to Commit? | What it has |
|------|---|---|
| `.env.example` | ✅ YES | Template only, no secrets |
| `.env.dev` | ❌ NO | YOUR dev secrets |
| `.env.staging` | ❌ NO | Staging secrets |
| `.env.prod` | ❌ NO | Production secrets |
| `.gitignore` | ✅ YES | Rules that protect the above |

**Everything is protected!** 🔒
