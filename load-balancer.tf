#Create Application Load Balancer
resource "aws_lb" "application_elb" {
  count              = "${var.create_application_load_balancer ? 1: 0}"
  name               = "${var.load_balancer_name}"
  internal           = "${var.internal}"
  load_balancer_type = "${var.load_balancer_type}"
  subnets            = ["${var.subnet_ids}"]
  security_groups    = ["${var.application_load_balancer_security_group_ids}"]

  enable_deletion_protection = false

  access_logs {
    bucket  = "${var.s3_bucket_name}"
    prefix  = "${var.prefix}"
    enabled = "${var.enable_elb_logging}"
  }
}

#Create Netwotk Load Balancer
resource "aws_lb" "network_elb" {
  count              = "${var.create_network_load_balancer ? 1: 0}"
  name               = "${var.load_balancer_name}"
  internal           = "${var.internal}"
  load_balancer_type = "${var.load_balancer_type}"
  subnets            = ["${var.subnet_ids}"]

  enable_deletion_protection = false

  access_logs {
    bucket  = "${var.s3_bucket_name}"
    prefix  = "${var.prefix}"
    enabled = "${var.enable_elb_logging}"
  }
}

#Create Application Load Balancer Target Group
resource "aws_lb_target_group" "application_target" {
  count       = "${var.create_application_lb_target_group ? 1: 0}"
  name        = "${var.target_group_name}"
  target_type = "${var.target_group_type}"
  port        = "${var.target_group_port}"
  protocol    = "${var.target_group_protocol}"
  vpc_id      = "${var.vpc_id}"

  #health check
  health_check {
    interval            = "${var.health_check_interval}"
    path                = "${var.health_check_path}"
    timeout             = "${var.health_check_timeout}"
    healthy_threshold   = "${var.health_check_healty_threshold}"
    unhealthy_threshold = "${var.health_check_unhealty_threshold}"
    matcher             = "${var.health_check_matcher}"
  }
}

#Create Network Load Balancer Target group
resource "aws_lb_target_group" "network_target" {
  count       = "${var.create_network_lb_target_group ? 1: 0}"
  name        = "${var.target_group_name}"
  target_type = "${var.target_group_type}"
  port        = "${var.target_group_port}"
  protocol    = "${var.target_group_protocol}"
  vpc_id      = "${var.vpc_id}"

  #health check
  health_check {
    interval            = "${var.health_check_interval}"
    healthy_threshold   = "${var.health_check_healty_threshold}"
    unhealthy_threshold = "${var.health_check_unhealty_threshold}"
  }
}

#Attach instances to application load balancer target group
resource "aws_lb_target_group_attachment" "application_attach" {
  count            = "${var.attach_instances_to_target_group && var.create_application_lb_target_group ? var.number_of_instances : 0}"
  target_group_arn = "${aws_lb_target_group.application_target.arn}"
  target_id        = "${element(aws_instance.this.*.id, count.index)}"

  depends_on = ["aws_lb_target_group.application_target"]
}

#Attach instances to network load balancer target group
resource "aws_lb_target_group_attachment" "network_attach" {
  count            = "${var.attach_instances_to_target_group && var.create_network_lb_target_group ? var.number_of_instances : 0}"
  target_group_arn = "${aws_lb_target_group.network_target.arn}"
  target_id        = "${element(aws_instance.this.*.id, count.index)}"

  depends_on = ["aws_lb_target_group.network_target"]
}

#Create Application Load Balancer Listener. SSL certificate management missing.
resource "aws_lb_listener" "applicaton_listener" {
  count             = "${var.create_listener && var.create_application_load_balancer && var.create_application_lb_target_group ? 1 : 0}"
  load_balancer_arn = "${aws_lb.application_elb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"
  certificate_arn   = "${var.listener_certificate_arn}"
  ssl_policy        = "${var.listener_ssl_policy}"

  default_action {
    type             = "${var.listener_action}"
    target_group_arn = "${aws_lb_target_group.application_target.arn}"
  }
}

#Create Network Load Balancer Listener. SSL certificate management missing.

resource "aws_lb_listener" "network_listener" {
  count             = "${var.create_listener && var.create_network_load_balancer && var.create_network_lb_target_group ? 1 : 0}"
  load_balancer_arn = "${aws_lb.network_elb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"
  certificate_arn   = "${var.listener_certificate_arn}"
  ssl_policy        = "${var.listener_ssl_policy}"

  default_action {
    type             = "${var.listener_action}"
    target_group_arn = "${aws_lb_target_group.network_target.arn}"
  }
}
