
locals {
  region  = "eu-central-1"
  profile = "default"
  cidr    = "10.10.0.0/16"

  private_subnets_map = {
    subnet_1 = {
      az   = "eu-central-1a"
      cidr = "10.0.1.0/24"
    }
    subnet_2 = {
      az   = "eu-central-1b"
      cidr = "10.0.2.0/24"
    }
  }
  public_subnets_map = {
    subnet_1 = {
      az   = "eu-central-1a"
      cidr = "10.10.101.0/24"
    }
    subnet_2 = {
      az   = "eu-central-1b"
      cidr = "10.10.102.0/24"
    }
  }
  app_name = "myapp"

  # Variables for ECS
  env               = "prod"
  fargate_cpu       = "512"
  fargate_memory    = "1024"
  image_tag         = "1"
  app_port          = "80"
  app_count         = "1"
  health_check_path = "/"

  # Variables for build server----
  instance_type = "t2.micro"
  github_url    = "https://github.com/davig2010/task4-tg.git"
  repo_owner    = "davig2010"
  repo_dir      = "task4-tg" # same as in github_url

  # Variables for ECR
  build_count = 3
}
# Indicate the input values to use for the variables of the module.
inputs = {
  region             = local.region
  profile            = local.profile
  cidr               = local.cidr
  profile            = local.profile
  public_subnets_map = local.public_subnets_map
  app_name           = local.app_name
  environment        = local.env
  fargate_cpu        = local.fargate_cpu
  fargate_memory     = local.fargate_memory
  image_tag          = local.image_tag
  app_port           = local.app_port
  app_count          = local.app_count
  health_check_path  = local.health_check_path
  instance_type      = local.instance_type
  github_url         = local.github_url
  repo_owner         = local.repo_owner
  repo_dir           = local.repo_dir
  build_count        = local.build_count

  default_tags = {
    "TerminationDate" = "Permanent",
    "Environment"     = "Production",
    "Team"            = "DevOps",
    "DeployedBy"      = "Terraform",
    "OwnerEmail"      = "devops@example.com"
    "Application"     = local.app_name
  }
}
# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = var.region
  default_tags {
    tags = var.default_tags
  }
}

variable "region" {
  description = "AWS Region."
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags for AWS that will be attached to each resource."
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "my-terraform-state-${local.env}-${local.app_name}-${local.region}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region}"
    encrypt        = true
    dynamodb_table = "my-lock-table-${local.env}-${local.app_name}"
  }
}
terraform {
  after_hook "remove_lock" {
    commands = [
      "apply",
      "console",
      "destroy",
      "import",
      "init",
      "plan",
      "push",
      "refresh",
    ]

    execute = [
      "rm",
      "-f",
      "${get_terragrunt_dir()}/.terraform.lock.hcl",
    ]

    run_on_error = true
  }
}

terraform_version_constraint = "1.2.9"

terragrunt_version_constraint = ">= 0.37.0"
