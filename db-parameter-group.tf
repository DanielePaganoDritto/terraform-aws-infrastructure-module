locals {
  parameter_group_description = "${coalesce(var.parameter_group_description, "Database parameter group for ${var.parameter_group_identifier}")}"
}

resource "aws_db_parameter_group" "this_no_prefix" {
  count = "${var.create_parameter_group && !var.use_name_prefix_for_parameter_group ? 1 : 0}"

  name        = "${var.parameter_group_name}"
  description = "${local.parameter_group_description}"
  family      = "${var.parameter_group_family}"

  parameter = ["${var.parameters}"]

  tags = "${merge(var.tags, map("Name", format("%s", var.parameter_group_name)))}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_parameter_group" "this" {
  count = "${var.create_parameter_group && var.use_name_prefix_for_parameter_group ?  1 : 0}"

  name_prefix = "${var.parameter_group_name_prefix}"
  description = "${local.parameter_group_description}"
  family      = "${var.parameter_group_family}"

  parameter = ["${var.parameters}"]

  tags = "${merge(var.tags, map("Name", format("%s", var.parameter_group_identifier)))}"

  lifecycle {
    create_before_destroy = true
  }
}