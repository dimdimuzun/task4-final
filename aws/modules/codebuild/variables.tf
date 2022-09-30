variable "environment" {
  description = "Environment name"
  type        = string
  default     = ""
}

variable "app_name" {
  description = "App name"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "A list of private subnets id inside the VPC"
  type        = string
  default     = ""
}

variable "public_subnets_id" {
  description = "A list of public subnets id inside the VPC"
  type        = list(string)
  default     = []
}

variable "codebuild_env_vars" {
  description = "Variables for codebuild"
  type        = map(any)
}

variable "github_url" {
  description = "Github url"
  type        = string
  default     = ""
}

variable "github_branch" {
  description = "Brunch name in Github for this environment"
  type        = string
  default     = ""
}

variable "github_event" {
  description = "Trigger in Github for start codebuild"
  type        = string
  default     = ""
}

variable "github_head_ref" {
  description = "Haed ref for start codebuild"
  type        = string
  default     = ""
}


# for token from SSM
variable "github_token" {

  default = "github_token"
}
