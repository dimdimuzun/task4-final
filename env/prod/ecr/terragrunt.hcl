terraform {
  source = "../../../aws/modules//ecr"
}
include {
  path = find_in_parent_folders()
}
