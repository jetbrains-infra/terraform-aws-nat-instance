variable "name" {
  default = "NatInstance"
}
variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}
variable "nat_subnet_id" {}
variable "instance_type" {
  default = "t3a.small"
}
variable "client_subnet_cidrs" {
  type = list(string)
}
variable "ports" {
  description = "List of ports allowed to connect from your VPC."
  type = object({
    tcp = list(number),
    udp = list(number),
  })
  default = {
    tcp = [443]
    udp = []
  }
}
variable "ami" {
  default = ""
}
variable "ami_owner_filter_values" {
  type        = list(string)
  description = "List of AMI owners to limit search. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g., amazon, aws-marketplace, microsoft)"
  default     = ["amazon"]
}
variable "ami_name_filter_values" {
  type        = list(string)
  description = "List of strings to use as the value of the name filter for the AMI to use"
  default     = ["amzn-ami-vpc-nat*"]
}
variable "internet_access" {
  default = true
}
variable "s3_endpoint" {
  default = false
}
data "aws_ami" "nat" {
  count       = var.ami == "" ? 1 : 0
  most_recent = true
  owners      = var.ami_owner_filter_values

  filter {
    name   = "name"
    values = var.ami_name_filter_values
  }
}
data "aws_subnet" "nat" {
  id = local.nat_subnet_id
}
data "aws_region" "current" {}

locals {
  name                = var.name
  vpc_id              = data.aws_subnet.nat.vpc_id
  instance_type       = var.instance_type
  nat_subnet_id       = var.nat_subnet_id
  client_subnet_cidrs = var.client_subnet_cidrs
  az                  = data.aws_subnet.nat.availability_zone
  ports               = var.ports
  ami                 = var.ami == "" ? data.aws_ami.nat[0].id : var.ami
  internet_route      = var.internet_access == true ? 1 : 0
  s3_endpoint         = var.s3_endpoint == true ? 1 : 0
  tags = merge({
    Name         = local.name
    Module       = "Nat Instance"
    ModuleSource = "https://github.com/jetbrains-infra/terraform-aws-nat-instance/"
  }, var.tags)
}
