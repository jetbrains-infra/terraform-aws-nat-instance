resource "aws_security_group" "nat" {
  name        = "Nat"
  description = "Default rules for Nat instance"
  vpc_id      = local.vpc_id
}

resource "aws_security_group_rule" "ingess_http" {
  type              = "ingress"
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  cidr_blocks       = local.private_subnet_cidrs
  security_group_id = aws_security_group.nat.id
}

resource "aws_security_group_rule" "ingess_https" {
  type              = "ingress"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  cidr_blocks       = local.private_subnet_cidrs
  security_group_id = aws_security_group.nat.id
}

resource "aws_security_group_rule" "egress_http" {
  type              = "egress"
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat.id
}

resource "aws_security_group_rule" "egress_https" {
  type              = "egress"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat.id
}