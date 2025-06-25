resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP, SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port    = 80
    to_port      = 80
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow access from web tier only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "PostgreSQL from Web tier"
    from_port    = 5432
    to_port      = 5432
    protocol     = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }
}
