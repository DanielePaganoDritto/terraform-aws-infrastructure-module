# terraform-aws-infrastructure-module
A Terraform module to create an AWS VPC
- Create AWS Key-Pair
- Create EC2 instance
- Create Security Group and Security Group Rules
- Create Application and Network Load Balancer
- Create Target Group 
- Create Load balancers Listener:
  - SSL certificates are not yet managed by this script
- RDS: source:https://github.com/terraform-aws-modules/terraform-aws-rds
  - create DB Subnet Group
  - Create DB Option Group
  - Create DB Parameter Group
  - Create RDS DB Instance

## Module Usage

Below an example on how to use the module. You need to configure the AWS provider first, in this case I have created a "Terraform" profile on my local machine with its own AWS Access Key and Secret Key:

```
provider "aws" {
  region  = "eu-west-1"
  profile = "terraform"
}

# Create Key Pair

module "key-pair" {
  source = "../terraform-aws-infrastructure-module"

  create_key_pair = "false"
  key_name        = "test-key-pair"
  public_key_path = "test-key-pair.pub"
}

#Create EC2 Instance
module "frontend_apps" {
  source = "../terraform-aws-infrastructure-module"

  # Select Availability Zones and Create Subnets
  azs       = ["eu-west-1a", "eu-west-1b"]
  az_letter = ["a", "b"]

  # Global tags
  tags = {
    "App Name" = "test-app"
    "Env"      = "test"
  }

  # Create Security Group with default ssh
  create_security_group = "true"
  vpc_id                = "my_vpc_id"  //Replace "my_vpc_id" with the VPC id where you want to deploy 
  security_group_name   = "test-sg"
  inbound_ip            = ["My_Public_IP"]   //Replace "My_Public_IP" with your own Public IP

  # Add rule to security group
  add_rule         = "false"
  from_port        = "80"
  to_port          = "80"
  rule_description = "Enable HTTP access"

  #Create Instances
  create_ec2          = "true"
  number_of_instances = "2"
  instance_name       = "ws-prod"
  key_name            = "fagiano"
  script_path         = "linux_initial_setup.sh"
  subnet_ids          = ["subnet-804f38c8", "subnet-0cb91856"]
  public_ip_on_launch = "false"

  #Create Public Network Load Balancer
  create_network_load_balancer = "true"
  load_balancer_name   = "prod-elb"
  load_balancer_type   = "network"

  #Create Public Application Load Balancer
  create_application_load_balancer = "false"
  application_load_balancer_security_group_ids = ["sg-0851beadf34d5bdaa"]
  load_balancer_name   = "prod-elb"
  load_balancer_type   = "network"

  #Create Application load balancer's target group
  create_application_lb_target_group   = "false"
  target_group_name     = "test-tg"
  target_group_type     = "instance"
  target_group_protocol = "HTTP"

  #Create network load balancer's target group
  create_network_lb_target_group   = "true"
  target_group_name     = "network-tg"
  target_group_type     = "instance"
  target_group_protocol = "TCP"
  health_check_healty_threshold     = "5"
  health_check_unhealty_threshold   = "5"

  #Attach instances to target group
  attach_instances_to_target_group = "true"

  #Enable Public Load Balancer Logging
  enable_elb_logging = "true"
  s3_bucket_name     = "elb-logs"
  prefix             = "prod_elb"

  #Create Listener
  create_listener   = "true"
  listener_port     = "80"
  listener_protocol = "TCP"
  listener_action   = "forward"

  #Create Subnet Group
  create_subnet_group = "true"
  subnet_group_name   = "subnet_group"
  subnet_group_identifier = "test database instances"
  db_subnet_ids = ["subnet-804f38c8", "subnet-0cb91856"]

  #Create RDS Instance
  create_rds = "true"
  rds_identifier = "test-db"
  rds_engine = "mysql"
  rds_engine_version = "5.7"
  rds_instance_class = "db.t2.micro"
  rds_allocated_storage = "10"
  rds_storage_type = "gp2"
  db_name = "mydb"
  db_username = "db_adm"
  db_password = "db_adm_pwd"
  db_subnet_group_name = "subnet_group"
  db_port = "3306"
  rds_parameter_group_name = "test-pg"
  rds_option_group_name = "test"

  #Create RDS Parameter Group
  create_parameter_group = "true"
  parameter_group_name = "test-pg"
  parameter_group_description = "test parameter group"
  parameter_group_family = "mysql5.7"

  #Create RDS Option Group
  create_option_group = "true"
  option_group_name = "test"
  option_group_identifier = "mysql_og"
  engine_name = "mysql"
  major_engine_version = "5.7"
}

```