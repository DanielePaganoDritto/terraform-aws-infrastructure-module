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
variable "create_load_balancer" {
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

variable "load_balancer_security_group_id" {
  description = "The security group id of the load balancer"
  default     = ""
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
