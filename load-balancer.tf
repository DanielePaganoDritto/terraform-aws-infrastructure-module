resource "aws_lb" "elb" {
  count              = "${var.create_load_balancer ? 1: 0}"
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

#Create target group
resource "aws_lb_target_group" "target_resource" {
  count       = "${var.create_target_group ? 1: 0}"
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

#Attach instances to target group
resource "aws_lb_target_group_attachment" "attach" {
  count            = "${var.attach_instances_to_target_group ? var.number_of_instances : 0}"
  target_group_arn = "${aws_lb_target_group.target_resource.arn}"
  target_id        = "${element(aws_instance.this.*.id, count.index)}"

  depends_on = ["aws_lb_target_group.target_resource"]
}

#Create Load Balancer Listener
resource "aws_lb_listener" "elb" {
  count             = "${var.create_listener ? 1 : 0}"
  load_balancer_arn = "${aws_lb.elb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"
  certificate_arn   = "${var.listener_certificate_arn}"
  ssl_policy        = "${var.listener_ssl_policy}"

  default_action {
    type             = "${var.listener_action}"
    target_group_arn = "${aws_lb_target_group.target_resource.arn}"
  }
}
