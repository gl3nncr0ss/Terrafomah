/* Private subnet NACLs */

resource "aws_network_acl" "private" {
  vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.vpc_name}-NACL-Private"
    }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 210
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 220
    action     = "allow"
    cidr_block = "${var.private_subnets}"
    from_port  = 3389
    to_port    = 3389
  }

  egress {
    protocol   = "tcp"
    rule_no    = 230
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1433
    to_port    = 1433
  }

  egress {
    protocol   = "tcp"
    rule_no    = 240
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 32768
    to_port    = 65535
  }

}

resource "aws_network_acl" "private_2" {
  vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.vpc_name}-NACL-Private-2"
    }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "${var.private_subnets}"
    from_port  = 1433
    to_port    = 1433
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "${var.public_subnets}"
    from_port  = 1433
    to_port    = 1433
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 230
    action     = "allow"
    cidr_block = "${var.private_subnets}"
    from_port  = 1433
    to_port    = 1433
  }

  egress {
    protocol   = "tcp"
    rule_no    = 240
    action     = "allow"
    cidr_block = "${var.public_subnets}"
    from_port  = 1433
    to_port    = 1433
  }

  egress {
    protocol   = "tcp"
    rule_no    = 250
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 32768
    to_port    = 65535
  }

}

/* Public Subnet NACLs */

resource "aws_network_acl" "public" {
  vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.vpc_name}-NACL-Public"
    }
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "${var.private_subnets_2}"
    from_port  = 1433
    to_port    = 1433
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 210
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 220
    action     = "allow"
    cidr_block = "${var.private_subnets}"
    from_port  = 3389
    to_port    = 3389
  }

  egress {
    protocol   = "tcp"
    rule_no    = 230
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1433
    to_port    = 1433
  }

  egress {
    protocol   = "tcp"
    rule_no    = 240
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 32768
    to_port    = 65535
  }

  egress { # PING
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_block = "0.0.0.0/0"
    rule_no    = 260
    action     = "allow"
  }

}
