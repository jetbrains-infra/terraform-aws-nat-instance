resource "aws_network_interface" "nat" {
  subnet_id         = local.public_subnet_id
  source_dest_check = false
  security_groups   = [aws_security_group.nat.id]
  tags              = local.tags
}

resource "aws_eip" "public_ip" {
  vpc               = true
  network_interface = aws_network_interface.nat.id
  tags              = local.tags
}

resource "aws_launch_template" "nat_instance" {
  name_prefix   = local.name
  image_id      = data.aws_ami.nat.id
  instance_type = local.instance_type
  tags          = local.tags

  network_interfaces {
    device_index         = 0
    network_interface_id = aws_network_interface.nat.id
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.tags
  }
}
