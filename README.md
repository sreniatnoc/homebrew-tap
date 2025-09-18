# 🍺 Homebrew Tap for K8sify

This is the official Homebrew tap for K8sify and related tools.

## Installation

```bash
# Add the tap
brew tap k8sify/tap

# Install k8sify
brew install k8sify
```

## Available Formulas

### K8sify
Intelligent Docker Compose to Kubernetes migration tool with cost analysis, security scanning, and production patterns.

```bash
brew install k8sify/tap/k8sify
```

## Usage

After installation, you can use k8sify from anywhere:

```bash
# Convert Docker Compose to Kubernetes
k8sify convert -i docker-compose.yml -o ./k8s

# Use interactive wizard
k8sify wizard

# Analyze your compose file
k8sify analyze -i docker-compose.yml

# Estimate costs
k8sify cost -i docker-compose.yml --provider aws

# Security scan
k8sify security -i docker-compose.yml
```

## Development

### Testing the Formula Locally

```bash
# Test the formula
brew test k8sify/tap/k8sify

# Install from local formula
brew install --build-from-source k8sify/tap/k8sify

# Reinstall after changes
brew reinstall k8sify/tap/k8sify
```

### Updating the Formula

The formula is automatically updated when new releases are created on GitHub. You can also update manually:

```bash
# Update tap
brew update

# Upgrade k8sify
brew upgrade k8sify
```

## Support

- [GitHub Issues](https://github.com/k8sify/k8sify/issues)
- [Documentation](https://github.com/k8sify/k8sify#readme)
- [Discord Community](https://discord.gg/k8sify)