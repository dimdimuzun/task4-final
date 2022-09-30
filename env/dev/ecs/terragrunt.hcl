terraform {
  source = "../../../aws/modules//ecs"
}
include {
  path = find_in_parent_folders()
}
dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id            = "vpc-000000000000"
    public_subnets_id = ["subnet-00000000000", "subnet-00000000001"]
    #private_subnets_id = ["subnet-00000000002", "subnet-00000000003"]
  }
}

dependency "ecr" {
  config_path = "../ecr"
  mock_outputs = {
    ecr_url = "vpc-000000000000"
  }
}

dependencies {
  paths = ["../local_build"]
}

inputs = {
  #private_subnets_id = dependency.vpc.outputs.private_subnets_id
  public_subnets_id = dependency.vpc.outputs.public_subnets_id
  vpc_id            = dependency.vpc.outputs.vpc_id
  ecr_url           = dependency.ecr.outputs.ecr_url
}
