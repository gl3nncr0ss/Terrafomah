output "public_subnet_id" {
  value = "${aws_subnet.public.id}"
}

output "private_subnet_id" {
  value = "${aws_subnet.private.id}"
}

output "private_subnet_2_id" {
  value = "${aws_subnet.private_2.id}"
}
