resource "aws_security_group" "nat" {
  name_prefix = "NatAz${title(substr(local.az, -1, -1))}"
  description = "Rules for Nat instance"
  vpc_id      = local.vpc_id
  tags        = local.tags

  dynamic "ingress" {
    for_each = local.ports.tcp
    content {
      cidr_blocks = local.client_subnet_cidrs
      from_port   = ingress.value
      protocol    = "tcp"
      to_port     = ingress.value
    }
  }

  dynamic "egress" {
    for_each = local.ports.tcp
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = egress.value
      protocol    = "tcp"
      to_port     = egress.value
    }
  }

  dynamic "ingress" {
    for_each = local.ports.udp
    content {
      cidr_blocks = local.client_subnet_cidrs
      from_port   = ingress.value
      protocol    = "udp"
      to_port     = ingress.value
    }
  }

  dynamic "egress" {
    for_each = local.ports.udp
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = egress.value
      protocol    = "udp"
      to_port     = egress.value
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
