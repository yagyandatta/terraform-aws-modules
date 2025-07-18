#---------------------------------------------#
# Input variables for AWS EFS module
#---------------------------------------------#

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "availability_zone_name" {
  description = "Specify to use One Zone EFS"
  type        = string
  default     = null
}

variable "creation_token" {
  description = "Unique identifier for the EFS"
  type        = string
  default     = "jrp"
}

variable "encrypted" {
  description = "Enable encryption at rest"
  type        = bool
  default     = true
}

variable "default_subnet_id" {
  description = "List of subnet IDs for EFS mount targets"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "VPC ID for EFS and security group"
  type        = string
}

variable "allowed_cidrs" {
  description = "CIDR blocks allowed to access EFS"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}
