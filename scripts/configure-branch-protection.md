# Branch Protection Configuration Guide

This guide will help you configure branch protection rules for all repositories in your Nx monorepo setup.

## Repositories to Configure

1. **Main Repository**: `JakubPilkowski/nx-mf-dynamic`
2. **Product Submodule**: `JakubPilkowski/nx-mf-dynamic-product`
3. **Checkout Submodule**: `JakubPilkowski/nx-mf-dynamic-checkout`

## Configuration Steps for Each Repository

### Step 1: Access Repository Settings

For each repository:
1. Go to the repository on GitHub
2. Click on "Settings" tab
3. Click on "Branches" in the left sidebar

### Step 2: Configure Main Branch Protection

For each repository, add a rule for the `main` branch:

#### Rule Name: `main`
- **Branch name pattern**: `main`
- **Require a pull request before merging**: ✅ **Enabled**
  - Require approvals: ✅ **Enabled** (at least 1)
  - Dismiss stale PR approvals when new commits are pushed: ✅ **Enabled**
  - Require review from code owners: ✅ **Enabled** (if you have CODEOWNERS)
- **Require status checks to pass before merging**: ✅ **Enabled**
  - Require branches to be up to date before merging: ✅ **Enabled**
  - Status checks that are required:
    - `Main CI` (or `ci` if that's the job name)
    - `Develop CI` (or `ci` if that's the job name)
- **Require conversation resolution before merging**: ✅ **Enabled**
- **Require signed commits**: ❌ **Disabled** (optional)
- **Require linear history**: ❌ **Disabled** (optional)
- **Require deployments to succeed before merging**: ❌ **Disabled** (optional)
- **Lock branch**: ❌ **Disabled**
- **Allow force pushes**: ❌ **Disabled**
- **Allow deletions**: ❌ **Disabled**

### Step 3: Configure Develop Branch Protection

For each repository, add a rule for the `develop` branch:

#### Rule Name: `develop`
- **Branch name pattern**: `develop`
- **Require a pull request before merging**: ❌ **Disabled**
- **Require status checks to pass before merging**: ❌ **Disabled**
- **Require conversation resolution before merging**: ❌ **Disabled**
- **Require signed commits**: ❌ **Disabled**
- **Require linear history**: ❌ **Disabled**
- **Require deployments to succeed before merging**: ❌ **Disabled**
- **Lock branch**: ❌ **Disabled**
- **Allow force pushes**: ✅ **Enabled**
- **Allow deletions**: ✅ **Enabled**

### Step 4: Configure Branch Access Rules (Optional)

To restrict pushes to main only from develop:

1. Go to "Settings" > "Branches"
2. Click "Add rule" for the main branch
3. Under "Restrict pushes that create files larger than 100 MB": ✅ **Enabled**
4. Under "Restrict pushes that create files larger than 100 MB": ✅ **Enabled**

## Required Status Checks

The following status checks should be required for the main branch:

### Main Repository (`nx-mf-dynamic`)
- `Main CI`
- `Develop CI`

### Product Submodule (`nx-mf-dynamic-product`)
- `Main CI`
- `Develop CI`

### Checkout Submodule (`nx-mf-dynamic-checkout`)
- `Main CI`
- `Develop CI`

## Verification Steps

After configuring all repositories:

1. **Test Develop Branch**:
   - Create a feature branch from develop
   - Make changes and push to develop
   - Verify CI workflows run successfully

2. **Test Main Branch Protection**:
   - Try to push directly to main (should be blocked)
   - Create a PR from develop to main
   - Verify that status checks are required
   - Verify that PR approval is required

3. **Test Submodule Workflows**:
   - Make changes in submodules
   - Push to develop branches
   - Verify submodule-specific workflows run

## Automation Script

You can use the following script to verify the setup:

```bash
#!/bin/bash
# verify-setup.sh

echo "Verifying branch protection setup..."

# Check if develop branches exist
echo "Checking develop branches..."
git ls-remote --heads origin develop | grep develop || echo "❌ develop branch not found"

# Check if workflows are present
echo "Checking workflows..."
ls -la .github/workflows/ || echo "❌ workflows not found"

# Check submodules
echo "Checking submodules..."
cd apps/product && ls -la .github/workflows/ && cd ../..
cd apps/checkout && ls -la .github/workflows/ && cd ../..

echo "✅ Setup verification complete"
```

## Troubleshooting

### Common Issues

1. **Workflows not running**: Check if workflows are in the correct branch
2. **Status checks not appearing**: Ensure workflows are properly named
3. **Branch protection not working**: Verify rule configuration
4. **Submodule workflows not triggering**: Check submodule configuration

### Support

If you encounter issues:
1. Check GitHub Actions logs
2. Verify branch protection rules
3. Ensure all workflows are properly committed and pushed 