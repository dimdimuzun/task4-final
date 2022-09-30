# Its a very simple CI/CD built by Terragrunt for two environments.

ITS BRANCH ONLY FOR DEV

DEV environment for CI/CD use Codebuild

## Description

1. When push or pull request in the /app/ folder you start deploy process

2. When changing the infrastructure in /env/dev, the infrastructure will be automatically updated.

## Folders and Files

- /app - Contain application
- /env/dev - Contain configuration for DEV infrastructure
