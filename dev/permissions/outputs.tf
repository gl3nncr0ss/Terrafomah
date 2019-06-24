output "bastion_sg_id" {
  value = "${aws_security_group.bastion.id}"
}

output "webserver_sg_id" {
  value = "${aws_security_group.web.id}"
}

output "MSSQL_sg_id" {
  value = "${aws_security_group.mindaDB.id}"
}
