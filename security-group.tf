#Create Security Group
resource "aws_security_group" "this" {
  count  = "${var.create_security_group && length(var.inbound_ip) > 0 ? 1 : 0 }"
  name   = "${var.security_group_name}"
  vpc_id = "${var.vpc_id}"

  # defaultSSH

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["${var.inbound_ip}"]
    description = "Enable SSH access"
  }
  
  tags = "${merge(map("Name", format("%s-%s", var.instance_name, "sg")), var.tags)}"
}

#Add rule to Security Group Rule
resource "aws_security_group_rule" "rule" {
  count             = "${var.add_rule && var.create_security_group && length(var.protocol) > 0 ? 1 : 0}"
  type              = "ingress"
  from_port         = "${var.from_port}"
  to_port           = "${var.to_port}"
  protocol          = "${var.protocol}"
  cidr_blocks       = "${var.inbound_ip}"
  security_group_id = "${aws_security_group.this.id}"
  description       = "${var.rule_description}"
}
