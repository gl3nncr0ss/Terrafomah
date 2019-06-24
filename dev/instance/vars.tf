variable "vpc_name" {}

variable "private_availability_zone" {}
variable "public_availability_zone" {}

variable "private_subnet_id" {}
variable "public_subnet_id" {}

variable "webserver_sg_id" {}
variable "bastion_sg_id" {}

variable "aws_key_name" {}

variable "admin_password" {}

variable "ami_web" {
    description = "The AMI for any AWS-MINDA web servers"
    default = "ami-ff27f09d" # WinServ 2016
}

variable "ami_app" {
    description = "The AMI for any AWS-MINDA app servers"
    default = "ami-ff27f09d" # WinServ 2016
}

variable "web_server_instance_type" {
    default = "t2.micro"
}

variable "app_server_instance_type" {
    default = "t2.micro"
}

variable "db_server_instance_type" {
    default = "t2.micro"
}

variable "ami_bastion" {
    description = "The AMI for the bastion server"
    default = "ami-75e13517" # WinServ 2016
}

variable "bastion_server_instance_type" {
    default = "t2.micro"
}
