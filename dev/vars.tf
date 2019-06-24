/* AWS ACCESS */
variable "aws_key_name" {}
variable "aws_key_path" {}

variable "admin_password" {}

variable "env" {}

variable "aws_region" {}

variable "cidr" {}

variable "name_prefix" {
  default = "LIC"
}

variable "public_availability_zone" {
  description = "Region of the public availability zone"
}

variable "private_availability_zone" {
  description = "Region of the private availability zone"
}

variable "private_subnets" {}
variable "public_subnets" {}

# RDS specific stuff
variable "private_availability_zone_2" {
  description = "Region of the private availability zone specifically for RDS"
}

variable "private_subnets_2" {
  description = "Private subnet specifically for RDS"
}
