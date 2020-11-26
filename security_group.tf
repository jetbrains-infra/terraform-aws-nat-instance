resource "aws_security_group" "nat" {
  name        = "Nat"
  description = "Rules for Nat instance"
  vpc_id      = local.vpc_id
  tags        = local.tags

  dynamic "ingress" {
    for_each = local.ports
    content {
      cidr_blocks = local.private_subnet_cidrs
      from_port   = ingress.value
      protocol    = "tcp"
      to_port     = ingress.value
    }
  }

  dynamic "egress" {
    for_each = local.ports
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = egress.value
      protocol    = "tcp"
      to_port     = egress.value
    }
  }
}
