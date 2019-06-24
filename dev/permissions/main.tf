/* Bastion Security Group */

resource "aws_security_group" "bastion" {
    name = "${var.vpc_name}-bastion"
    description = "Allow incoming RDP connections."

    ingress { # RDP
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress { # WinRM
        from_port   = 5985
        to_port     = 5986
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { # SQL Server
        from_port = 1433
        to_port = 1433
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnets}"]
    }

    egress { # SQL Server
        from_port = 1433
        to_port = 1433
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnets_2}"]
    }

    egress { # RDP
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnets}"]
    }

    egress { # SSH
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnets}"]
    }

    egress { # HTTP
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { # HTTPS
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { # PING
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      }

    vpc_id = "${var.vpc_id}"

    tags {
        Name = "${var.vpc_name}-Bastion-SG"
    }
}

/* Webserver Security Group */

resource "aws_security_group" "web" {
    name = "${var.vpc_name}-web"
    description = "Allow incoming RDP connections."

    ingress { # RDP
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        security_groups = ["${aws_security_group.bastion.id}"]
    }

    ingress { # WinRM
        from_port   = 5985
        to_port     = 5986
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { # SQL Server
        from_port = 1433
        to_port = 1433
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnets}"]
    }

    egress { # SQL Server
        from_port = 1433
        to_port = 1433
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnets_2}"]
    }

    egress { # HTTP
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # ALB IP range
        }

    egress { # HTTPS
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # ALB IP range
        }

    egress { # PING
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
        }

    vpc_id = "${var.vpc_id}"

    tags {
        Name = "${var.vpc_name}-Web-SG"
    }
}

/* RDS Security Group */

resource "aws_security_group" "mindaDB" {
  name = "${var.vpc_name}-MSSQL"
  description = "Microsoft SQL server RDS (terraform-managed)"
  vpc_id = "${var.vpc_id}"

  tags {
      Name = "${var.vpc_name}-MindaMSSQL-SG"
  }

  ingress { # RDP
      from_port = 1433
      to_port = 1433
      protocol = "tcp"
      security_groups = ["${aws_security_group.bastion.id}", "${aws_security_group.web.id}"]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
