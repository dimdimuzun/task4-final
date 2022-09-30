terraform {
  source = "../../../aws/modules//codebuild"
}
include {
  path = find_in_parent_folders()
}
dependencies {
  paths = ["../ecs"]
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id            = "vpc-fake"
    public_subnets_id = ["subnet-fake-1", "subnet-fake-2"]

  }
}
inputs = merge(
  {

    public_subnets_id = dependency.vpc.outputs.public_subnets_id
    vpc_id            = dependency.vpc.outputs.vpc_id
    build_spec_file   = "env/dev/buildspec.yml"
  }
)
