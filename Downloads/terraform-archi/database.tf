resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = values(aws_subnet.private)[*].id
}

resource "aws_db_instance" "app_db" {
  identifier           = "app-db"
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot  = true
}
