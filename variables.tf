#### Tags Variables
variable "instance_name" {
  description = "The name of the application to deploy"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

#### Availability Zone Variables 
variable "azs" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "az_letter" {
  description = "The availability zone letter identification"
  default     = []
}

#### Key Pair Variables
variable "create_key_pair" {
  description = "should be set to true in order to create a key-pair"
  default     = "false"
}

variable "public_key_path" {
  description = "The path to the public key file to import in AWS"
  default     = ""
}

#### Security Group Variables
variable "create_security_group" {
  description = "Should be set to true in order to enable security group creation"
  default     = "false"
}

variable "security_group_name" {
  description = "The name of the security group to create"
  default     = ""
}

variable "add_rule" {
  description = "Should be set to true in order to add a rule to a newly created security group"
  default     = "false"
}

variable "vpc_id" {
  description = "The VPC ID in which you wanto to create the security group"
  default     = ""
}

variable "from_port" {
  description = "Inbound port for security group"
  default     = ""
}

variable "to_port" {
  description = "Outbound port for security group"
  default     = ""
}

variable "inbound_ip" {
  description = "The inbound IP address/CIDR for the security group rule"
  default     = []
}

variable "protocol" {
  description = "The protocol of the new rule to add"
  default     = "tcp"
}

variable "rule_type" {
  description = "The protocol of the new rule to add"
  default     = "tcp"
}

variable "rule_description" {
  description = "The description of the security rule to add"
  default     = ""
}

#### EC2 Instance Variables
variable "create_ec2" {
  description = "Should be set to true in order to create an ec2 instance"
  default     = "false"
}

variable "number_of_instances" {
  description = "Number of EC2 instances to create"
  default     = "2"
}

variable "public_ip_on_launch" {
  description = "Should be set to true if you want to associate a pubblic IP to the instance on launch"
  default     = "false"
}

variable "subnet_type" {
  description = "The type of subnet (Public, Private, Data) in which to create the instance"
  default     = "public-c"
}

variable "subnet_ids" {
  description = "ID of the subnet in which to deploy the instance"
  default     = []
}

variable "instance_type" {
  description = "The type of ec2 instance to create"
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "The ami to create the instance from (default centos7)"
  default     = "ami-0ff760d16d9497662"
}

variable "key_name" {
  description = "The key pair name to use for the instance"
  default     = ""
}

variable "script_path" {
  description = "The path for the configuration script to launch in Userdata"
  default     = ""
}

variable "security_group_ids" {
  description = "The Security Groups to use for the instance"
  default     = []
}

#Load Balancer Variables
variable "create_application_load_balancer" {
  description = "Should be set to true in order to create a new load balancer"
  default     = "false"
}

variable "create_network_load_balancer" {
  description = "Should be set to true in order to create a new load balancer"
  default     = "false"
}

variable "load_balancer_name" {
  description = "The name of the load balancer"
  default     = ""
}

variable "internal" {
  description = "Should be set to true in order to create an internal load balancer"
  default     = "false"
}

variable "load_balancer_type" {
  description = "The Load Balancer type to create: application, network, classic"
  default     = "application"
}

variable "application_load_balancer_security_group_ids" {
  description = "The security group id of the load balancer"
  default     = []
}

variable "enable_elb_logging" {
  description = "Should be set to true in order to enable elastic load balancer logging"
  default     = "false"
}

variable "s3_bucket_name" {
  description = "The S3 bucket where to save elb logs"
  default     = ""
}

variable "prefix" {
  description = "The prefix of the elb logs directory in S3"
  default     = ""
}

#Target Group Variables
variable "attach_instances_to_target_group" {
  description = "Should be set to true to enable instance attachment to a target group"
  default     = "false"
}

variable "create_application_lb_target_group" {
  description = "Should be set to true in order to create a new target group"
  default     = "false"
}

variable "create_network_lb_target_group" {
  description = "Should be set to true in order to create a new target group"
  default     = "false"
}

variable "target_group_name" {
  description = "The name of the target group to create"
  default     = ""
}

variable "target_group_type" {
  description = "The type of targets you want to create: instance, ip, lambda"
  default     = "instance"
}

variable "target_group_port" {
  description = "The listening port of the target group to create"
  default     = "80"
}

variable "target_group_protocol" {
  description = "The protocol of the target group to create"
  default     = "HTTP"
}

variable "health_check_interval" {
  description = "The approximate amount of time between health checks of an individual target (5-300 seconds). Default 30s"
  default     = "30"
}

variable "health_check_path" {
  description = "The destination path for health checks. This path must begin with a '/' character"
  default     = "/"
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check (2-120 seconds)"
  default     = "5"
}

variable "health_check_healty_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy (2-10)"
  default     = "5"
}

variable "health_check_unhealty_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy (2-10)."
  default     = "2"
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target (e.g. 200)"
  default     = "200"
}

#Load Balancer Listener Variables
variable "create_listener" {
  description = "Should be set to true to create a listener"
  default     = "false"
}

variable "listener_port" {
  description = "The port number from which to listen to for traffic"
  default     = "80"
}

variable "listener_protocol" {
  description = "The protocol for connections from the client"
  default     = "HTTP"
}

variable "listener_certificate_arn" {
  description = "The ARN of the default SSL server certificate (Optional)."
  default     = ""
}

variable "listener_action" {
  description = "The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc"
  default     = ""
}

variable "listener_ssl_policy" {
  description = "(Optional) The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS."
  default     = ""
}

#RDS Variables
variable "create_rds" {
  description = "Should be set to true to enable RDS instance creation"
  default = "false"
}

variable "rds_identifier" {
  description = "The name of the RDS instance in AWS console"
  default =""
}

variable "rds_engine" {
  description = "The database engine to use"
  default     = ""
}

variable "rds_engine_version" {
  description = "The database engine version to use"
  default     = ""
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance"
  default = "db.t2.micro"
}

variable "rds_allocated_storage" {
  description = "The amount of storage to use for database data"
  default = "10"
}

variable "rds_storage_type" {
  description = "The type of storage to use for database data: gp2, io1..."
  default = "gp2"
}

variable "rds_storage_encrypted" {
  description = "Should be set to true in order to enable db disk encryption"
  default = "false"
}

variable "rds_character_set_name" {
  description = "(Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information"
  default     = ""
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  default = ""
}

variable "rds_license_model" {
  description = "The license model to use for the rds instance: byol, license-included, etc."
  default = ""
}

variable "db_name" {
  description = "The name of the database to initialize in the rds instance"
  default     = ""
}

variable "db_username" {
  description = "The 'root' user that wll have access to the db instance created"
  default     = ""
}

variable "db_password" {
  description = "The password for the 'root' user that wll have access to the db instance created"
  default     = ""
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  default = ""
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  default     = "false"
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  default     = ""
}

variable "rds_parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  default     = ""
}

variable "rds_option_group_name" {
  description = "Name of the DB option group to associate."
  default     = ""
}

variable "rds_availability_zone" {
  description = "The Availability Zone of the RDS instance"
  default     = ""
}

variable "rds_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = "false"
}

variable "rds_iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  default     = "0"
}

variable "rds_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = false
}

variable "rds_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = "0"
}

variable "rds_monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  default     = ""
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  default     = "false"
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = "true"
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = "false"
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default     = ""
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted."
  default     = "false"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  default     = "true"
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
  default     = "false"
}

variable "rds_backup_retention_period" {
  description = "The days to retain backups for"
  default     = "1"
}

variable "rds_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default     = ""
}

variable "rds_mssql_timezone" {
  description = "(Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information."
  default     = ""
}

variable "rds_enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  default     = []
}

variable "rds_deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  default     = "false"
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
  default     = ""
}

#RDS Option Group Variables
variable "create_option_group" {
  description = "Whether to create this resource or not?"
  default     = "false"
}

variable "option_group_name" {
  description = "Name of the DB option group to associate."
  default     = ""
}
variable "option_group_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix"
  default     = "og"
}

variable "option_group_identifier" {
  description = "The identifier of the resource"
  default     = ""
}

variable "option_group_description" {
  description = "The description of the option group"
  default     = ""
}

variable "engine_name" {
  description = "Specifies the name of the engine that this option group should be associated with"
  default     = ""
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  default     = ""
}

variable "options" {
  type        = "list"
  description = "A list of Options to apply"
  default     = []
}

#RDS Parameter Group Variables

variable "create_parameter_group" {
  description = "Should be set to true to enable parameter group creation"
  default     = "false"
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  default     = ""
}

variable "parameter_group_description" {
  default     = ""
  description = "The description of the DB parameter group"
}

variable "parameter_group_name_prefix" {
  default     = ""
  description = "Creates a unique name beginning with the specified prefix"
}

variable "parameter_group_family" {
  description = "The family of the DB parameter group"
  default     = ""
}

variable "parameters" {
  description = "A list of DB parameter maps to apply"
  default     = []
}

variable "parameter_group_identifier" {
  description = "The identifier of the resource"
  default = ""
}

variable "use_name_prefix_for_parameter_group" {
  description = "Whether to use name_prefix or not"
  default     = "false"
}

# Subnet Group Variables
variable "create_subnet_group" {
  description = "Whether to create this resource or not?"
  default     = "false"
}

variable "subnet_group_name" {
  description = "Creates a unique name for the subnet group"
  default = ""
}

variable "subnet_group_identifier" {
  description = "The identifier of the resource"
  default = ""
}

variable "db_subnet_ids" {
  type        = "list"
  description = "A list of VPC subnet IDs"
  default     = []
}
