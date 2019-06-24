terraform {
  backend "s3" {
    bucket = "minda-terraform-state"
    key = "Dev/terraform.tfstate"
    region = "ap-southeast-2"
  }
}

module "vpc" {
  source = "./vpc"

  cidr = "${var.cidr}"
  aws_region = "${var.aws_region}"
  name_prefix = "${var.name_prefix}"
  env = "${var.env}"
}

module "subnets" {
  source = "./subnets"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_name = "${module.vpc.vpc_name}"
  private_availability_zone = "${var.private_availability_zone}"
  private_availability_zone_2 = "${var.private_availability_zone_2}"
  public_availability_zone = "${var.public_availability_zone}"
  private_subnets = "${var.private_subnets}"
  private_subnets_2 = "${var.private_subnets_2}"
  public_subnets = "${var.public_subnets}"
}

module "igw" {
  source = "./igw"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_name = "${module.vpc.vpc_name}"
}

module "route_tables" {
  source = "./route_tables"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_name = "${module.vpc.vpc_name}"
  public_subnet_id = "${module.subnets.public_subnet_id}"
  private_subnet_id = "${module.subnets.private_subnet_id}"
  private_subnet_id_2 = "${module.subnets.private_subnet_2_id}"
  private_subnets = "${var.private_subnets}"
  private_subnets_2 = "${var.private_subnets_2}"
  public_subnets = "${var.public_subnets}"
  igw_id = "${module.igw.igw_id}"
}

module "natgw" {
  source = "./natgw"

  vpc_name = "${module.vpc.vpc_name}"
  private_route_table_id = "${module.route_tables.private_route_table_id}"
  private_route_table_id_2 = "${module.route_tables.private_route_table_id_2}"
  public_subnet_id = "${module.subnets.public_subnet_id}"
}

module "nacls" {
  source = "./nacls"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_name = "${module.vpc.vpc_name}"
  public_subnets = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"
  private_subnets_2 = "${var.private_subnets_2}"
}

module "permissions" {
  source = "./permissions"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_name = "${module.vpc.vpc_name}"
  private_subnets = "${var.private_subnets}"
  private_subnets_2 = "${var.private_subnets_2}"
  public_subnets = "${var.public_subnets}"
}

module "S3endpoint" {
  source = "./S3endpoint"
  vpc_id = "${module.vpc.vpc_id}"
  vpc_name = "${module.vpc.vpc_name}"
  private_route_table_id = "${module.route_tables.private_route_table_id}"
  public_route_table_id = "${module.route_tables.public_route_table_id}"
}

module "instance" {
  source = "./instance"

  vpc_name = "${module.vpc.vpc_name}"
  public_subnet_id = "${module.subnets.public_subnet_id}"
  private_subnet_id = "${module.subnets.private_subnet_id}"
  private_availability_zone = "${var.private_availability_zone}"
  public_availability_zone = "${var.public_availability_zone}"
  aws_key_name = "${var.aws_key_name}"
  webserver_sg_id = "${module.permissions.webserver_sg_id}"
  bastion_sg_id = "${module.permissions.bastion_sg_id}"
  admin_password = "${var.admin_password}"
}

module "RDS" {
  source = "./RDS"

  vpc_name = "${module.vpc.vpc_name}"
  private_subnet_id = "${module.subnets.private_subnet_id}"
  private_subnet_2_id = "${module.subnets.private_subnet_2_id}"
  admin_password = "${var.admin_password}"
  rds_sg_id = "${module.permissions.MSSQL_sg_id}"
  env = "${var.env}"
}
