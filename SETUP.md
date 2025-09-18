# Homebrew Tap Setup Instructions

This document provides step-by-step instructions for publishing the K8sify Homebrew tap.

## Prerequisites

1. **GitHub Account**: You need access to create a repository under the `k8sify` organization
2. **Homebrew**: Ensure Homebrew is installed on your system
3. **Git**: Git should be installed and configured

## Step 1: Create GitHub Repository

1. Go to GitHub and create a new repository under the `k8sify` organization
2. Name the repository: `homebrew-tap` (this is required for Homebrew naming conventions)
3. Make the repository public
4. Don't initialize with README, .gitignore, or license (we already have these files)

## Step 2: Push Tap to GitHub

```bash
# Navigate to the tap directory
cd homebrew-tap

# Add all files
git add .

# Create initial commit
git commit -m "Initial K8sify Homebrew tap

- Add Formula/k8sify.rb with Rust build instructions
- Add README with installation and usage instructions
- Add setup documentation"

# Add GitHub remote (replace with actual URL)
git remote add origin https://github.com/k8sify/homebrew-tap.git

# Push to GitHub
git push -u origin main
```

## Step 3: Test the Tap

Once published, users can test the tap:

```bash
# Add the tap
brew tap k8sify/tap

# Install k8sify
brew install k8sify/tap/k8sify

# Test installation
k8sify --version
```

## Step 4: Update Formula for Releases

When you create releases of k8sify, you'll need to update the formula:

### Automatic Updates (Recommended)

Create a GitHub Action in the main k8sify repository to automatically update the formula:

```yaml
# .github/workflows/homebrew.yml in main k8sify repo
name: Update Homebrew Formula

on:
  release:
    types: [published]

jobs:
  homebrew:
    runs-on: ubuntu-latest
    steps:
    - name: Update Homebrew formula
      uses: dawidd6/action-homebrew-bump-formula@v3
      with:
        token: ${{ secrets.HOMEBREW_TAP_TOKEN }}
        tap: k8sify/homebrew-tap
        formula: k8sify
        tag: ${{ github.ref }}
        revision: ${{ github.sha }}
```

### Manual Updates

1. Download the release archive and calculate its SHA256:
   ```bash
   curl -sL https://github.com/k8sify/k8sify/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
   ```

2. Update `Formula/k8sify.rb`:
   - Change the `url` to the new release
   - Update the `sha256` with the calculated hash
   - Update the `version` if needed

3. Commit and push the changes

## Step 5: Verify Installation Works

Test the complete installation flow:

```bash
# Remove any existing installation
brew uninstall k8sify || true
brew untap k8sify/tap || true

# Fresh installation
brew tap k8sify/tap
brew install k8sify/tap/k8sify

# Verify it works
k8sify --help
k8sify --version
```

## Step 6: Update Main Repository

Update the main k8sify repository's README to reflect that the brew install command now works:

- Ensure the installation section shows: `brew install k8sify/tap/k8sify`
- Add a note that the tap is now available

## Troubleshooting

### Formula Issues
- Use `ruby -c Formula/k8sify.rb` to check syntax
- Check Homebrew documentation for formula requirements

### Installation Issues
- Ensure Rust is available as a build dependency
- Check that the repository URL is accessible
- Verify the SHA256 hash matches the archive

### Tap Issues
- Ensure the repository name follows the `homebrew-*` convention
- Check that the Formula directory contains the `.rb` file
- Verify repository is public

## Maintenance

- Monitor GitHub issues in the tap repository
- Update the formula when new k8sify releases are published
- Keep dependencies and build instructions up to date
- Test the formula periodically to ensure it still works

## Support

For issues with the Homebrew tap:
1. Check existing issues in the homebrew-tap repository
2. Create new issues with detailed error messages
3. Test locally before reporting issues