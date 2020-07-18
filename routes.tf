resource "aws_route_table" "nat" {
  vpc_id = local.vpc_id
  tags   = local.tags
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.nat.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.nat.id
}
