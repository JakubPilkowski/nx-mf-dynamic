#!/bin/bash

echo "🔍 Verifying Nx monorepo setup with GitHub workflows..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
    fi
}

echo ""
echo "📋 Checking main repository..."

# Check if develop branch exists in main repo
if git ls-remote --heads origin develop | grep -q develop; then
    print_status 0 "Develop branch exists in main repository"
else
    print_status 1 "Develop branch missing in main repository"
fi

# Check if workflows exist in main repo
if [ -d ".github/workflows" ]; then
    print_status 0 "Workflows directory exists in main repository"
    
    # Check specific workflow files
    if [ -f ".github/workflows/base.yml" ]; then
        print_status 0 "Base workflow exists"
    else
        print_status 1 "Base workflow missing"
    fi
    
    if [ -f ".github/workflows/develop.yml" ]; then
        print_status 0 "Develop workflow exists"
    else
        print_status 1 "Develop workflow missing"
    fi
    
    if [ -f ".github/workflows/main.yml" ]; then
        print_status 0 "Main workflow exists"
    else
        print_status 1 "Main workflow missing"
    fi
else
    print_status 1 "Workflows directory missing in main repository"
fi

echo ""
echo "📦 Checking submodules..."

# Check product submodule
echo "  Product submodule:"
if [ -d "apps/product" ]; then
    cd apps/product
    
    if git ls-remote --heads origin develop | grep -q develop; then
        print_status 0 "    Develop branch exists"
    else
        print_status 1 "    Develop branch missing"
    fi
    
    if [ -d ".github/workflows" ]; then
        print_status 0 "    Workflows directory exists"
        
        if [ -f ".github/workflows/base.yml" ]; then
            print_status 0 "    Base workflow exists"
        else
            print_status 1 "    Base workflow missing"
        fi
    else
        print_status 1 "    Workflows directory missing"
    fi
    
    cd ../..
else
    print_status 1 "Product submodule directory missing"
fi

# Check checkout submodule
echo "  Checkout submodule:"
if [ -d "apps/checkout" ]; then
    cd apps/checkout
    
    if git ls-remote --heads origin develop | grep -q develop; then
        print_status 0 "    Develop branch exists"
    else
        print_status 1 "    Develop branch missing"
    fi
    
    if [ -d ".github/workflows" ]; then
        print_status 0 "    Workflows directory exists"
        
        if [ -f ".github/workflows/base.yml" ]; then
            print_status 0 "    Base workflow exists"
        else
            print_status 1 "    Base workflow missing"
        fi
    else
        print_status 1 "    Workflows directory missing"
    fi
    
    cd ../..
else
    print_status 1 "Checkout submodule directory missing"
fi

echo ""
echo "🔗 Checking git submodules configuration..."
if [ -f ".gitmodules" ]; then
    print_status 0 "Git submodules file exists"
    echo "  Configured submodules:"
    cat .gitmodules | grep "submodule" | while read line; do
        echo "    $line"
    done
else
    print_status 1 "Git submodules file missing"
fi

echo ""
echo "📝 Checking Nx configuration..."
if [ -f "nx.json" ]; then
    print_status 0 "Nx configuration exists"
    
    # Check if release configuration exists
    if grep -q "release" nx.json; then
        print_status 0 "Release configuration found in nx.json"
    else
        print_status 1 "Release configuration missing in nx.json"
    fi
else
    print_status 1 "Nx configuration missing"
fi

echo ""
echo "🎯 Next Steps:"
echo "1. Configure branch protection rules manually in GitHub:"
echo "   - Main repository: https://github.com/JakubPilkowski/nx-mf-dynamic/settings/branches"
echo "   - Product submodule: https://github.com/JakubPilkowski/nx-mf-dynamic-product/settings/branches"
echo "   - Checkout submodule: https://github.com/JakubPilkowski/nx-mf-dynamic-checkout/settings/branches"
echo ""
echo "2. Follow the configuration guide in scripts/configure-branch-protection.md"
echo ""
echo "3. Test the setup by creating a PR from develop to main"
echo ""
echo "✅ Setup verification complete!" 