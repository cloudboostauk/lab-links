resource "aws_route_table_association" "cba_subnet_rt_public" {
  subnet_id      = aws_subnet.cba_public.id
  route_table_id = aws_route_table.cba_public_rt.id
}