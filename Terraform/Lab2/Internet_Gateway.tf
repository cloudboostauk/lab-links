resource "aws_internet_gateway" "cba_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "ApacheIGW"
  }
}