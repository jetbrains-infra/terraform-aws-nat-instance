## About
Terraform module to create nat instance. The module provides a security group for Nat instance. The security group allows
only 80/443 ports by default.   

## Usage

```hcl
module "nat" {
  source    = "github.com/jetbrains-infra/terraform-aws-nat-instance"
  subnet_id = local.subnet_id
}
```


```hcl
module "nat" {
  source             = "github.com/jetbrains-infra/terraform-aws-nat-instance"
  name               = "NatInstance"
  subnet_id          = local.subnet_id
  instance_type      = "t3a.small"
  security_group_ids = [aws_security_group.main.id]
}
```

## Outputs

* `route_table_id` - route table id 
* `eip` - public IP address of NAT instance
* `security_group_arn` - ARN of NAT instance security group 
