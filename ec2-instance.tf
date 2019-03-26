#Create key pair

resource "aws_key_pair" "this" {
  count      = "${var.create_key_pair && length(var.key_name) >0 ? 1 : 0}"
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

#Create EC2 instance
resource "aws_instance" "this" {
  count                       = "${var.create_ec2 && length(var.subnet_ids) > 0 ? var.number_of_instances :0}"
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ec2_ami}"
  associate_public_ip_address = "${var.public_ip_on_launch}"
  user_data                   = "${file(var.script_path)}"

  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.this.id}"]
  subnet_id              = "${element(var.subnet_ids, count.index)}"
  tags = "${merge(map("Name", format("%s-%s", var.instance_name, element(var.az_letter, count.index))), var.tags)}"
}
