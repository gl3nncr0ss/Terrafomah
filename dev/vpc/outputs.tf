output "vpc_id" {
  value = "${aws_vpc.mod.id}"
}

output "vpc_name" {
  value = "LIC-${var.env}"
}
