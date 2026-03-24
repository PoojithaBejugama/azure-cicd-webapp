#!/bin/bash
# ============================================
# LOAD ENVIRONMENT VARIABLES SCRIPT (Bash)
# ============================================
# Usage: source load-env.sh dev

if [ -z "$1" ]; then
    echo "❌ Usage: source load-env.sh <environment>"
    echo "   Examples: source load-env.sh dev"
    echo "             source load-env.sh staging"
    echo "             source load-env.sh prod"
    return 1
fi

ENVIRONMENT=$1
ENV_FILE=".env.$ENVIRONMENT"

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ File '$ENV_FILE' not found in current directory"
    echo "Please run this script from the 'infra' directory"
    return 1
fi

echo "✓ Loading environment variables from $ENV_FILE..."
echo ""

COUNT=0
while IFS= read -r line; do
    # Skip empty lines and comments
    if [ -n "$line" ] && [[ ! "$line" =~ ^# ]]; then
        if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
            NAME="${BASH_REMATCH[1]}"
            VALUE="${BASH_REMATCH[2]}"
            
            # Remove quotes
            VALUE="${VALUE%\"}"
            VALUE="${VALUE#\"}"
            VALUE="${VALUE%\'}"
            VALUE="${VALUE#\'}"
            
            export "$NAME=$VALUE"
            
            # Display (mask secrets)
            if [[ "$NAME" =~ SECRET|PASSWORD|KEY|TOKEN|SUBSCRIPTION ]]; then
                echo "  ✓ $NAME = ****"
            else
                echo "  ✓ $NAME = $VALUE"
            fi
            ((COUNT++))
        fi
    fi
done < "$ENV_FILE"

echo ""
echo "✓ Loaded $COUNT environment variable(s)"
echo ""
echo "Next steps:"
echo "  cd env/$ENVIRONMENT"
echo "  terraform init"
echo "  terraform plan"
