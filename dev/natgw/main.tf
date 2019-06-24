/* Requires: internet gateway module, vpc name, public subnet id, private route table id */

/* NAT Gateway */

resource "aws_eip" "nateip" {
  vpc   = true

  tags {
      Name = "${var.vpc_name}-NatGW-EIP"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.nateip.id}"
  subnet_id     = "${var.public_subnet_id}"

#  depends_on = ["module.igw"]

  tags {
    Name = "${var.vpc_name}-NatGW"
  }
}

/* NAT Gateway Routing */

resource "aws_route" "public_nat_gateway" {
  route_table_id         = "${var.private_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = "${aws_nat_gateway.natgw.id}"
}

resource "aws_route" "public_nat_gateway_2" {
  route_table_id         = "${var.private_route_table_id_2}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = "${aws_nat_gateway.natgw.id}"
}
