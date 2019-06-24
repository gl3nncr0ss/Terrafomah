/* Requires: vpc name, vpc id, internet gateway id, private and public subnet ids */

/* Private Route Table */

resource "aws_route_table" "private" {
  vpc_id           = "${var.vpc_id}"
  # propagating_vgws = ["${var.private_propagating_vgws}"]

  tags {
    Name = "${var.vpc_name}-rt-private"
  }
}

resource "aws_route_table" "private_2" {
  vpc_id           = "${var.vpc_id}"
  # propagating_vgws = ["${var.private_propagating_vgws}"]

  tags {
    Name = "${var.vpc_name}-rt-private-2"
  }
}

/* Private Subnet Association */

resource "aws_route_table_association" "private" {
  subnet_id      = "${var.private_subnet_id}"
  route_table_id = "${aws_route_table.private.id}"
}

/* Private Subnet 2 Association */

resource "aws_route_table_association" "private_2" {
  subnet_id      = "${var.private_subnet_id_2}"
  route_table_id = "${aws_route_table.private_2.id}"
}

/* Public Route Table */

resource "aws_route_table" "public" {
  vpc_id           = "${var.vpc_id}"
  # propagating_vgws = ["${var.public_propagating_vgws}"]

  tags {
    Name = "${var.vpc_name}-rt-public"
  }
}

/* Public Subnet Association */

resource "aws_route_table_association" "public" {
  subnet_id      = "${var.public_subnet_id}"
  route_table_id = "${aws_route_table.public.id}"
}

/* Public Internet Gateway Routing */

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.igw_id}"
}
