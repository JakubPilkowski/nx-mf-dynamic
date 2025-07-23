# GitHub Workflow Setup

This document describes the GitHub workflow setup for the Nx monorepo with submodules.

## Workflow Structure

### Main Repository Workflows

- `.github/workflows/base.yml` - Base CI workflow that can be invoked by other workflows
- `.github/workflows/develop.yml` - Triggers on develop branch pushes and PRs
- `.github/workflows/main.yml` - Triggers on main branch pushes and PRs

### Submodule Workflows

Each submodule has its own set of workflows:

- `apps/product/.github/workflows/` - Product submodule workflows
- `apps/checkout/.github/workflows/` - Checkout submodule workflows

## Branch Structure

### Main Repository

- `main` - Production branch (protected)
- `develop` - Development branch (can be deleted)

### Submodules

- `main` - Production branch (protected)
- `develop` - Development branch (can be deleted)

## Branch Protection Rules

### Main Branch Protection

For each repository (main + submodules):

- ✅ Require a pull request before merging
- ✅ Require approvals (at least 1)
- ✅ Require status checks to pass before merging
- ✅ Require branches to be up to date before merging
- ✅ Restrict pushes that create files larger than 100 MB
- ✅ Allow force pushes (disabled)
- ✅ Allow deletions (disabled)

### Develop Branch Protection

For each repository (main + submodules):

- ✅ Allow force pushes
- ✅ Allow deletions
- ✅ No other restrictions

### Branch Access Rules

- Only allow pushes to `main` from `develop` branch
- All other branches can be created and deleted freely

## Setup Instructions

1. **Run the setup script:**

   ```bash
   ./scripts/setup-branches.sh
   ```

2. **Configure branch protection rules in GitHub:**

   - Go to Settings > Branches
   - Add rule for `main` branch with the protection settings above
   - Add rule for `develop` branch with the protection settings above

3. **Set up required status checks:**

   - Main CI
   - Develop CI
   - Any other required checks

4. **Configure branch access rules:**
   - Only allow pushes to `main` from `develop`

## Workflow Execution

### Develop Branch

- Triggers on push to `develop`
- Triggers on pull request to `develop`
- Runs lint, test, and build tasks
- Uses `develop` start method

### Main Branch

- Triggers on push to `main`
- Triggers on pull request to `main`
- Runs lint, test, and build tasks
- Uses `main` start method

## Submodule Workflows

Each submodule has its own CI workflows that:

- Run independently of the main repository
- Focus on their specific project (e.g., `--project=product`)
- Follow the same branch protection rules
- Can be triggered independently

## Nx Integration

The workflows are optimized for Nx:

- Uses Nx Cloud for task distribution (commented out by default)
- Runs `nx run-many` for efficient task execution
- Uses `nx fix-ci` for self-healing CI
- Caches node_modules for faster builds
