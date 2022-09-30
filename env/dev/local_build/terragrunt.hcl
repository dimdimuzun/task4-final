terraform {
  source = "../../../aws/modules//local_build"
}
include {
  path = find_in_parent_folders()
}
dependency "ecr" {
  config_path = "../ecr"
  mock_outputs = {
    ecr_url     = "000000000000.dkr.ecr.eu-central-1.amazonaws.com/image"
    registry_id = "000000000000"
  }
  # skip_outputs = true
}


inputs = merge(
  {
    ecr_url     = dependency.ecr.outputs.ecr_url
    registry_id = dependency.ecr.outputs.registry_id

  }
)
