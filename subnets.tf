resource "aws_subnet" "public" {
  for_each                = toset(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  for_each   = toset(var.private_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
}
