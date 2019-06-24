/* S3 Endpoint */

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id = "${var.vpc_id}"
  service_name = "com.amazonaws.ap-southeast-2.s3"
  route_table_ids = ["${var.private_route_table_id}","${var.public_route_table_id}"]
}
