resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "minda_subnet_group"
  subnet_ids = ["${var.private_subnet_id}", "${var.private_subnet_2_id}"]
}

resource "aws_db_instance" "MindaLiveDB" {
  allocated_storage        = 20 # gigabytes
  #backup_retention_period = 0
  db_subnet_group_name     = "${aws_db_subnet_group.rds_subnet_group.name}"
  engine                   = "sqlserver-ex"
  engine_version           = "14.00.1000.169.v1"
  identifier               = "mindaweb-db"
  instance_class           = "db.t2.micro"
  multi_az                 = false
  #name                     = "${var.vpc_name}-MindaWeb-DB"
  username                 = "mindaweb"
  password                 = "${var.admin_password}"
  port                     = 1433
  publicly_accessible      = false
  storage_encrypted        = false # you should always do this
  storage_type             = "gp2"
  license_model             = "license-included"
  username                 = "mindaweb"
  vpc_security_group_ids   = ["${var.rds_sg_id}"]

  tags = {
    name = "${var.vpc_name}-MindaWeb-DB"
  }
}
