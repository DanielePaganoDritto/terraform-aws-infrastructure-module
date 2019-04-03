
#Create DB Option Group
resource "aws_db_option_group" "this" {
  count = "${var.create_option_group ? 1 : 0}"

  name                     = "${var.option_group_name}"
  option_group_description = "${var.option_group_description == "" ? format("Option group for %s", var.option_group_identifier) : var.option_group_description}"
  engine_name              = "${var.engine_name}"
  major_engine_version     = "${var.major_engine_version}"

  option = ["${var.options}"]

  tags = "${merge(var.tags, map("Name", format("%s", var.option_group_identifier)))}"

  lifecycle {
    create_before_destroy = true
  }
}