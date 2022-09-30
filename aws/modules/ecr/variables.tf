
variable "app_name" {
  description = "Application name"
  type        = string
  default     = ""
}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = ""
}
variable "build_count" {
  description = "How leave images"
  type        = number
  default     = 3
}
