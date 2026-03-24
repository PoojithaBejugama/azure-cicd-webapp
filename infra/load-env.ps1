# ============================================
# LOAD ENVIRONMENT VARIABLES SCRIPT
# ============================================
# Usage: . load-env.ps1 -Environment dev

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("dev", "staging", "prod")]
    [string]$Environment
)

$envFile = ".\.env.$Environment"

if (!(Test-Path $envFile)) {
    Write-Error "❌ File '$envFile' not found in current directory"
    Write-Host "Please run this script from the 'infra' directory"
    exit 1
}

Write-Host "✓ Loading environment variables from $envFile..." -ForegroundColor Green

$count = 0
Get-Content $envFile | ForEach-Object {
    # Skip empty lines and comments
    if ($_.Trim() -and -not $_.StartsWith("#")) {
        if ($_ -match '^\s*(.+?)\s*=\s*(.*)$') {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim()
            
            # Remove quotes if present
            $value = $value -replace '^"(.*)"$', '$1'
            $value = $value -replace "^'(.*)'$", '$1'
            
            [System.Environment]::SetEnvironmentVariable($name, $value)
            
            # Display (mask secrets)
            if ($name -match "SECRET|PASSWORD|KEY|TOKEN|ID" -and $value) {
                Write-Host "  ✓ $name = ****"
            } else {
                Write-Host "  ✓ $name = $value"
            }
            $count++
        }
    }
}

Write-Host ""
Write-Host "✓ Loaded $count environment variable(s)" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  cd env\$Environment"
Write-Host "  terraform init"
Write-Host "  terraform plan"
