## About
Terraform module to create NAT instance. The module provides:

* NAT instance security group with rules allowed 443 port by default
* VPC S3 Logs endpoints to avoid passing internal traffic through NAT

## Usage

```hcl
module "nat" {
  source               = "github.com/jetbrains-infra/terraform-aws-nat-instance?ref=vX.X.X" // https://github.com/jetbrains-infra/terraform-aws-routed-subnet/releases/latest
  subnet_id            = local.subnet_id
  public_subnet_id     = modules.public_subnet.id // see https://github.com/jetbrains-infra/terraform-aws-routed-subnet
  private_subnet_cidrs = [modules.private_subnet.cidr]
  ports                = [443, 3306]
}
```

Default values
```hcl
module "nat" {
  source               = "github.com/jetbrains-infra/terraform-aws-nat-instance?ref=vX.X.X" // https://github.com/jetbrains-infra/terraform-aws-routed-subnet/releases/latest
  name                 = "NatInstance"
  subnet_id            = local.subnet_id
  instance_type        = "t3a.small"
  public_subnet_id     = modules.public_subnet.id // see https://github.com/jetbrains-infra/terraform-aws-routed-subnet
  private_subnet_cidrs = [modules.private_subnet.cidr]
  ports                = [443, 53] 
}
```

## Outputs

* `route_table_id` - route table id 
* `eip` - public IP address of NAT instance
* `security_group_arn` - ARN of NAT instance security group 
* `security_group_id` - ID of NAT instance security group 
