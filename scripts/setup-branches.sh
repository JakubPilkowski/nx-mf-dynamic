#!/bin/bash

# Setup branches for the main repository and submodules
echo "Setting up branches for main repository and submodules..."

# Create develop branch in main repository
git checkout -b develop
git push -u origin develop

# Setup submodules
echo "Setting up submodules..."

# Product submodule
cd apps/product
git checkout -b develop
git push -u origin develop
cd ../..

# Checkout submodule
cd apps/checkout
git checkout -b develop
git push -u origin develop
cd ../..

echo "Branches created successfully!"
echo ""
echo "Next steps:"
echo "1. Set up branch protection rules in GitHub:"
echo "   - develop branch: Allow force pushes, allow deletions"
echo "   - main branch: Require pull request reviews, require status checks"
echo "2. Configure branch protection to only allow pushes to main from develop"
echo "3. Set up required status checks for CI workflows" 