terraform {
  required_version = "> 0.8.0"
}

resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "ls -la; chmod +x build.sh; ls -la; ./build.sh"

    environment = {
      region       = var.region
      ecr_url      = var.ecr_url
      registry_id  = var.registry_id
      github_url   = var.github_url
      app_name     = var.app_name
      image_tag    = var.image_tag
      repo_dir     = var.repo_dir
      repo_owner   = var.repo_owner
      github_token = data.aws_ssm_parameter.github_token.value


    }
  }
}
