resource "aws_security_group" "nat" {
  name        = "Nat"
  description = "Rules for Nat instance"
  vpc_id      = local.vpc_id
  tags        = local.tags
}

resource "aws_security_group_rule" "ingress" {
  count             = length(local.ports)
  type              = "ingress"
  from_port         = element(local.ports, count.index)
  protocol          = "tcp"
  to_port           = element(local.ports, count.index)
  cidr_blocks       = local.private_subnet_cidrs
  security_group_id = aws_security_group.nat.id
}

resource "aws_security_group_rule" "egress" {
  count             = length(local.ports)
  type              = "egress"
  from_port         = element(local.ports, count.index)
  protocol          = "tcp"
  to_port           = element(local.ports, count.index)
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat.id
}
