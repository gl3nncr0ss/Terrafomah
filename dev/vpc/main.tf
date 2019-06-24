/* VPC */

resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  instance_tenancy     = "default"

  tags {
    Name = "LIC-${var.env}"
  }


  lifecycle {
    create_before_destroy = true
  }
}
