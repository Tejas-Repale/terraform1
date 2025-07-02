resource "aws_db_instance" "db" {
  identifier              = var.identifier_name
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = 20
  db_name                 = var.db_name
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = var.username
  manage_master_user_password = true         #  Turn off to avoid KMS requirement
  parameter_group_name    = "default.mysql5.7"
  skip_final_snapshot     = true
  storage_encrypted       = false             #  Disable encryption
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = var.subnet_group_name
  multi_az                = true
  tags                    = var.tags_rds
}
