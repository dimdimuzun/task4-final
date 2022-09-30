variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = ""
}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = ""
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = ""
}
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
variable "public_subnets_map" {
  description = "Public subnets map"
  type = map(object({
    az   = string
    cidr = string
  }))

}
/*
variable "private_subnets_map" {
  description = "Private subnets map"
  type = map(object({
    az   = string
    cidr = string
  }))
  
}

*/
