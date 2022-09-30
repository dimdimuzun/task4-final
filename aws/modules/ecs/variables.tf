
#vars for task definition
variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = ""
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = ""
}

variable "ecr_url" {
  description = "ecr url"
  type        = string
  default     = ""
}

variable "environment" {
  type = string
}

variable "app_name" {
  type = string
}

variable "image_tag" {
  type = string
}
variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = ""
}
# vars for security
variable "vpc_id" {
  description = "A list of private subnets id inside the VPC"
  type        = string
  default     = ""
}
variable "app_count" {
  description = "Number of docker containers to run"
  default     = ""
}
# vars for ecs and alb files
variable "public_subnets_id" {
  description = "A list of public subnets id inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets_id" {
  description = "A list of private subnets id inside the VPC"
  type        = list(string)
  default     = []
}

variable "health_check_path" {
  default = ""
}
# for roles
variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "TaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "ECS task role name"
  default = "TaskRole"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role Name"
  default = "AutoScaleRole"
}
