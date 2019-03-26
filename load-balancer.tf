resource "aws_lb" "this" {
  count = "${var.create_load_balancer ? 1: 0}"
  name               = "${var.load_balancer_name}"
  internal           = "${var.internal}"
  load_balancer_type = "${var.load_balancer_type}"
  subnets            = ["${var.subnet_ids}"]
  
  enable_deletion_protection = true

/*
  access_logs {
    count = "${var.enabled ? 1 : 0}"
    bucket  = "${aws_s3_bucket.this.bucket}"
    prefix  = "${var.prefix}"
    enabled = "${var.enabled}"
  }
  */
}