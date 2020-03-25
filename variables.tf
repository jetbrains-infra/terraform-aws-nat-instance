variable "name" {
  default = "NatInstance"
}
variable "public_subnet_id" {}
variable "instance_type" {
  default = "t3a.small"
}
variable "private_subnet_cidrs" {
  type = list(string)
}

data "aws_ami" "nat" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }
}

data "aws_subnet" "nat" {
  id = local.public_subnet_ids[0]
}

data "aws_region" "current" {}

locals {
  name                 = var.name
  vpc_id               = data.aws_subnet.nat.vpc_id
  instance_type        = var.instance_type
  public_subnet_ids    = [var.public_subnet_id]
  private_subnet_cidrs = var.private_subnet_cidrs
}