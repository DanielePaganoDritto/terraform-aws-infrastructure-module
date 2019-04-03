resource "aws_db_subnet_group" "this" {
  count = "${var.create_subnet_group ? 1 : 0}"
 
  name  = "${var.subnet_group_name}"
  description = "Database subnet group for ${var.subnet_group_identifier}"
  subnet_ids  = ["${var.db_subnet_ids}"]

  tags = "${merge(var.tags, map("Name", format("%s", var.subnet_group_identifier)))}"
}