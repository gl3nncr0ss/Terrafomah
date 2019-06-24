/* Requires:  vpc id, vpc name, the VPC module */

/* Private Subnet(s) */

resource "aws_subnet" "private" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.private_subnets}"
  availability_zone = "${var.private_availability_zone}"

  tags {
    Name = "${var.vpc_name}-subnet-private"
  }

#  depends_on = ["module.vpc"]
}

/* Public Subnet(s) */

resource "aws_subnet" "public" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.public_subnets}"
  availability_zone = "${var.public_availability_zone}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.vpc_name}-subnet-public"
  }

#  depends_on = ["module.vpc"]
}

# Private subnet for RDS
resource "aws_subnet" "private_2" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.private_subnets_2}"
  availability_zone = "${var.private_availability_zone_2}"

  tags {
    Name = "${var.vpc_name}-subnet-private-2"
  }

#  depends_on = ["module.vpc"]
}
