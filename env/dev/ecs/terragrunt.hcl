terraform {
  source = "../../../aws/modules//ecs"
}
include {
  path = find_in_parent_folders()
}
dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id            = "vpc-fake"
    public_subnets_id = ["subnet-fake", "subnet-fake"]

  }
}

dependency "ecr" {
  config_path = "../ecr"
  mock_outputs = {
    ecr_url = "vpc-fake"
  }
}

dependencies {
  paths = ["../local_build"]
}

inputs = {

  public_subnets_id = dependency.vpc.outputs.public_subnets_id
  vpc_id            = dependency.vpc.outputs.vpc_id
  ecr_url           = dependency.ecr.outputs.ecr_url
}
