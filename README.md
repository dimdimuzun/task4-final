# Its a very simple CI/CD built by Terragrunt for two environments:

DEV environment for CI/CD use Codebuild

PROD environment use Github Action

All environments use AWS: VPC, ECR, ECS

## ATTENTION!

Please read ALL README to the end, before making any changes.

#### Tools :

- Git or any web-browser

## Deployment

1. In AWS System Manager Parameter Store:

- Add value Github token with key-name: github_token

2. For each environment add Secrets credentials in Github:

- for DEV:

  - AWS_ACCESS_KEY_ID_DEV = AWS Account ID for DEV
  - AWS_SECRET_ACCESS_KEY_DEV = AWS Account KEY for DEV

- for PROD:
  - AWS_ACCESS_KEY_ID_PROD = AWS Account ID for PROD
  - AWS_SECRET_ACCESS_KEY_PROD = AWS Account KEY for PROD

3. Clone repository from github on PC or open in browser Github repository
4. Add changes in root terragrunt.hcl in each /env/ subdirs and push in Github
5. Infrastructure will be created in 5-6 minutes

   You will see Load balansers DNS names for each environment in Actions in Github

### Destroy infrastructure

- for auto-delete DEV infrastructure, push anything in /destroy/dev/

- for auto-delete PROD infrastructure, push anything in /destroy/prod/

## Description

1. When push or pull request in the /app/ folder in the:

- MAIN branch, an update will occur for PROD.

- DEV branch, an update will occur for DEV.

2. When changing the infrastructure in /env/dev or /env/prod/, the infrastructure will be automatically updated accordingly.

## Folders and some Files

- .github/workflows - Contain YUML files for Github Action
  - ./app.yml - config for auto-deploy from /app
  - ./dev_auto_destroy.yml - for auto-destroy DEV infrastructure
  - ./dev_auto.yml - for auto-create DEV infrastructure
  - ./prod_auto_destroy.yml - for auto-destroy PROD infrastructure
  - ./prod_auto.yml - for auto-create PROD infrastructure
- /app - Main Application folder
- /aws - Terraform modules directory
  - ./codebuild - configuration for "codebuild" module
  - ./ecr - configuration for "ecr" module
  - ./ecs - configuration for "ecs cluster" module
  - ./build - configuration for "init-build" module
  - ./vpc - configuration for "vpc" module
- /destroy - directory for auto-destroy
  - ./dev- any changes in that directory will rin auto-delete "developers" environment
  - ./prod- ny changes in that directory will rin auto-delete "production" environment
- /env - Terraform directory
  - ./dev- configuration for creating "developers" environment
    - ./buildspec.yml - Build SPEC for AWS Codebuild
  - ./prod- configuration for creating "production" environment

## Configuration

Main configuration files are the next:

- /env/dev/terragrunt.hcl - Contains main variables for "dev" environments

- /env/prod/terragrunt.hcl - Contains main variables for "prod" environments

All information about variables write in descriptions for each variable in variables.tf
