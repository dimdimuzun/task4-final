resource "aws_codebuild_source_credential" "this" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = data.aws_ssm_parameter.github_token.value
}
resource "aws_codebuild_project" "this" {
  depends_on = [aws_codebuild_source_credential.this]

  name          = "cb-project-${var.environment}-${var.app_name}"
  description   = "codebuild_project_${var.environment}_${var.app_name}"
  build_timeout = "120"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }
 
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type         = "LINUX_CONTAINER"
    # The privileged flag must be set so that your project has the required Docker permissions
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    dynamic "environment_variable" {
      for_each = var.codebuild_env_vars
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  source {
    buildspec           = "env/${var.environment}/buildspec.yml"
    type                = "GITHUB"
    location            = var.github_url
    git_clone_depth     = 1
    report_build_status = "true"
    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = var.github_branch
 
}

resource "aws_codebuild_webhook" "webhook" {
  project_name = aws_codebuild_project.this.name
  filter_group {
    filter {
      type    = "EVENT"
      pattern = var.github_event
    }
    filter {
      type    = "HEAD_REF"
      pattern = var.github_head_ref
    }
  }
}
