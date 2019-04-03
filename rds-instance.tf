locals {
     is_mssql = "${element(split("-",var.rds_engine), 0) == "sqlserver"}"
}

#Create an RDS Non-MSSQL DB Instance
resource "aws_db_instance" "this" {
  count = "${var.create_rds && !local.is_mssql  && length(var.rds_identifier) > 0 && length(var.db_port) > 0 ? 1 : 0}"

  identifier = "${var.rds_identifier}"

  engine            = "${var.rds_engine}"
  engine_version    = "${var.rds_engine_version}"
  instance_class    = "${var.rds_instance_class}"
  allocated_storage = "${var.rds_allocated_storage}"
  storage_type      = "${var.rds_storage_type}"
  storage_encrypted = "${var.rds_storage_encrypted}"
  kms_key_id        = "${var.kms_key_id}"
  license_model     = "${var.rds_license_model}"

  name                                = "${var.db_name}"
  username                            = "${var.db_username}"
  password                            = "${var.db_password}"
  port                                = "${var.db_port}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"

  replicate_source_db = "${var.replicate_source_db}"

  snapshot_identifier = "${var.snapshot_identifier}"

  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name   = "${var.db_subnet_group_name}"
  parameter_group_name   = "${var.parameter_group_name}"
  option_group_name      = "${var.option_group_name}"

  availability_zone   = "${var.rds_availability_zone}"
  multi_az            = "${var.rds_multi_az}"
  iops                = "${var.rds_iops}"
  publicly_accessible = "${var.rds_publicly_accessible}"
  monitoring_interval = "${var.rds_monitoring_interval}"
  monitoring_role_arn = "${var.rds_monitoring_role_arn}"

  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"
  skip_final_snapshot         = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot       = "${var.copy_tags_to_snapshot}"
  final_snapshot_identifier   = "${var.final_snapshot_identifier}"

  backup_retention_period = "${var.rds_backup_retention_period}"
  backup_window           = "${var.rds_backup_window}"

  character_set_name = "${var.rds_character_set_name}"

  enabled_cloudwatch_logs_exports = "${var.rds_enabled_cloudwatch_logs_exports}"

  deletion_protection = "${var.rds_deletion_protection}"

  tags = "${merge(var.tags, map("Name", format("%s", var.rds_identifier)))}"
}

#Create an RDS MSSQL DB instnce
resource "aws_db_instance" "this_mssql" {
  count = "${var.create_rds && local.is_mssql && length(var.rds_identifier) >0 && length(var.db_port) > 0 ? 1 : 0}"

  identifier = "${var.rds_identifier}"

  engine            = "${var.rds_engine}"
  engine_version    = "${var.rds_engine_version}"
  instance_class    = "${var.rds_instance_class}"
  allocated_storage = "${var.rds_allocated_storage}"
  storage_type      = "${var.rds_storage_type}"
  storage_encrypted = "${var.rds_storage_encrypted}"
  kms_key_id        = "${var.kms_key_id}"
  license_model     = "${var.rds_license_model}"

  name                                = "${var.db_name}"
  username                            = "${var.db_username}"
  password                            = "${var.db_password}"
  port                                = "${var.db_port}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"

  replicate_source_db = "${var.replicate_source_db}"

  snapshot_identifier = "${var.snapshot_identifier}"

  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name   = "${var.db_subnet_group_name}"
  parameter_group_name   = "${var.rds_parameter_group_name}"
  option_group_name      = "${var.rds_option_group_name}"

  availability_zone   = "${var.rds_availability_zone}"
  multi_az            = "${var.rds_multi_az}"
  iops                = "${var.rds_iops}"
  publicly_accessible = "${var.rds_publicly_accessible}"
  monitoring_interval = "${var.rds_monitoring_interval}"
  monitoring_role_arn = "${var.rds_monitoring_role_arn}"

  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"
  skip_final_snapshot         = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot       = "${var.copy_tags_to_snapshot}"
  final_snapshot_identifier   = "${var.final_snapshot_identifier}"

  backup_retention_period = "${var.rds_backup_retention_period}"
  backup_window           = "${var.rds_backup_window}"

  timezone = "${var.rds_mssql_timezone}"

  enabled_cloudwatch_logs_exports = "${var.rds_enabled_cloudwatch_logs_exports}"

  deletion_protection = "${var.rds_deletion_protection}"

  tags = "${merge(var.tags, map("Name", format("%s", var.rds_identifier)))}"
}
