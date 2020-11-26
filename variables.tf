variable "name" {
  default = "NatInstance"
}
variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
variable "public_subnet_id" {}
variable "instance_type" {
  default = "t3a.small"
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "ports" {
  description = "List of ports allowed to connect from your VPC."
  type        = list(number)
  default     = [443]
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
  id = local.public_subnet_id
}
data "aws_region" "current" {}

locals {
  name                 = var.name
  vpc_id               = data.aws_subnet.nat.vpc_id
  instance_type        = var.instance_type
  public_subnet_id     = var.public_subnet_id
  private_subnet_cidrs = var.private_subnet_cidrs
  az                   = data.aws_subnet.nat.availability_zone
  ports                = var.ports
  tags = merge({
    Name         = local.name
    Module       = "Nat Instance"
    ModuleSource = "https://github.com/jetbrains-infra/terraform-aws-nat-instance/"
  }, var.tags)
}