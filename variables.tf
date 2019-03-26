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
  default = "2"
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
  default = []
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
  default = "false"
}

variable "load_balancer_name" {
  description = "The name of the load balancer"
  default = ""
}

variable "internal" {
  description = "Should be set to true in order to create an internal load balancer"
  default = "false"
}

variable "load_balancer_type" {
  description = "The Load Balancer type to create: application, network, classic"
  default = "application"
}

variable "load_balancer_security_group_id" {
  description = "The security group id of the load balancer"
  default = ""
}

variable "enabled" {
  description = "Should be set to true in order to enable elastic load balancer logging"
  default = "false" 
}