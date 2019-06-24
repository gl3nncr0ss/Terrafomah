variable "name_prefix" {}

variable "env" {
  description = "The environment stage"
}

variable "cidr" {}

variable "enable_dns_hostnames" {
  description = "Should private DNS be used within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "Should private DNS be used within the VPC"
  default     = true
}

variable "aws_region" {
  description = "Which region will the VPC sit in?"
}
