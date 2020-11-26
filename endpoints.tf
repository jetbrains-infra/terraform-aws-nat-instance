resource "aws_vpc_endpoint" "s3" {
  vpc_id          = local.vpc_id
  service_name    = "com.amazonaws.${data.aws_region.current.name}.s3"
  auto_accept     = true
  route_table_ids = [aws_route_table.nat.id]
  tags            = local.tags
}

resource "aws_vpc_endpoint" "ecr" {
  vpc_id              = local.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  auto_accept         = true
  route_table_ids     = [aws_route_table.nat.id]
  tags                = local.tags
}
