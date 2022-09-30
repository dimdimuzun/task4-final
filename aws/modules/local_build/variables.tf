
variable "ecr_url" {
  description = "ecr url"
  type        = string
  default     = ""
}
variable "registry_id" {
  description = "registry id"
  type        = string
  default     = ""
}
variable "github_url" {
  description = "github url"
  type        = string
  default     = ""
}
variable "app_name" {
  description = "app name"
  type        = string
  default     = ""
}
variable "image_tag" {
  description = "Tag for initial image"
  type        = string
}
variable "repo_dir" {
  description = "main dir name in github"
  type        = string
  default     = ""
}


variable "repo_owner" {
  description = "Github owner name"
  type        = string
  default     = ""
}
variable "github_token" {
  description = "Github token in SSM"
  type        = string
  default     = "github_token"
}

