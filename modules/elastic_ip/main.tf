resource "aws_eip" "my_eip" {
  depends_on = [var.igw]  # Or aws_internet_gateway.my_igw if you're referencing a resource
  tags       = var.tags_eip
}
