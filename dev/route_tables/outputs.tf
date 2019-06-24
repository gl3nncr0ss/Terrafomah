output "private_route_table_id" {
  value = "${aws_route_table.private.id}"
}

output "private_route_table_id_2" {
  value = "${aws_route_table.private_2.id}"
}

output "public_route_table_id" {
  value = "${aws_route_table.public.id}"
}
