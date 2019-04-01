# terraform-aws-infrastructure-module
A Terraform module to create an AWS VPC
- Create AWS Key-Pair
- Create EC2 instance
- Create Security Group and Security Group Rules
- Create Application and Network Load Balancer
- Create Target Group 
- Create Load balancers Listener
  - SSL certificates are not yet managed by this script

## Module Usage

Below an example on how to use the module. You need to configure the AWS provider first, in this case I have created a "Terraform" profile on my local machine with its own AWS Access Key and Secret Key:

```
provider "aws" {
  region  = "eu-west-1"
  profile = "Terraform"
}

# Create Key Pair

module "key-pair" {
  source = "../aws-modules/aws-application-module/"

  create_key_pair = "false"
  key_name        = "test-key-pair"
  public_key_path = "test-key-pair.pub"
}

#Create EC2 Instance
module "ec2" {
  source = "../aws-modules/aws-application-module/"

  # Select Availability Zones and Create Subnets
  azs       = ["eu-west-1a", "eu-west-1b"]
  az_letter = ["a", "b"]

  # Global tags
  tags = {
    "App Name" = "gargolla"
    "Env"      = "test"
  }

  # Create Security Group with default ssh
  create_security_group = "true"
  vpc_id                = "vpc-5d547e3b"
  security_group_name   = "test-sg"
  inbound_ip            = ["54.245.117.134/32"]

  # Add rule to security group
  add_rule         = "false"
  from_port        = "80"
  to_port          = "80"
  rule_description = "Enable HTTP access"

  #Create Instances
  create_ec2          = "true"
  number_of_instances = "2"
  instance_name       = "ws-prod"
  key_name            = "test-key-pair"
  script_path         = "linux_initial_setup.sh"
  subnet_ids          = ["subnet-826sf8f1", "subnet-04b78819"]
  public_ip_on_launch = "false"

  #Create Public Load Balancer
  create_load_balancer = "true"
  load_balancer_name   = "prod-elb"
  load_balancer_type   = "application"

  #Create load balancer's target group
  create_target_group   = "true"
  target_group_name     = "test-tg"
  target_group_type     = "instance"
  target_group_protocol = "HTTP"

  #Attach instances to target group
  attach_instances_to_target_group = "true"

  #Enable Public Load Balancer Logging
  enable_elb_logging = "true"
  s3_bucket_name     = "elb-logs"
  prefix             = "prod_elb"

  #Create Listener
  create_listener   = "true"
  listener_port     = "80"
  listener_protocol = "HTTP"
  listener_action   = "forward"
}

```