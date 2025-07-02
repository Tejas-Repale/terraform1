# RDS Private Subnet 1a
module "subnet_rds_priv_1a" {
  source      = "./modules/subnet"
  vpc_id      = module.my_vpc.my_vpc_id
  cidr_subnet = "172.16.10.0/24"
  az_subnet   = "ap-south-1a"
  public      = false
  tags_subnet = {
    Name = "tf-priv-rds-ap-south-1a"
    Kind = "practice"
  }
}

# RDS Private Subnet 1b
module "subnet_rds_priv_1b" {
  source      = "./modules/subnet"
  vpc_id      = module.my_vpc.my_vpc_id
  cidr_subnet = "172.16.11.0/24"
  az_subnet   = "ap-south-1b"
  public      = false
  tags_subnet = {
    Name = "tf-priv-rds-ap-south-1b"
    Kind = "practice"
  }
}

# Route Table Associations for RDS subnets
module "rt_ass_rds_priv_1a" {
  source         = "./modules/rt_association"
  subnet_id      = module.subnet_rds_priv_1a.subnet_id
  route_table_id = module.private_rt.rt_id
}

module "rt_ass_rds_priv_1b" {
  source         = "./modules/rt_association"
  subnet_id      = module.subnet_rds_priv_1b.subnet_id
  route_table_id = module.private_rt.rt_id
}

# Security Group for RDS
module "sg_rds" {
  source = "./modules/security_group"

  ingress_rules = [
    {
      description     = "allow on 3306"
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]

  egress_rules = [
    {
      description     = "allow"
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]

  vpc_id         = module.my_vpc.my_vpc_id
  sg_name        = "tf_sg_rds"
  sg_description = "SG for RDS"

  tags_sg = {
    Name = "tf-db-sg"
    Kind = "practice"
  }
}

# DB Subnet Group
module "db_subnet_group" {
  source = "./modules/subnet_group"

  subnet_ids_subnet_group = [
    module.subnet_rds_priv_1a.subnet_id,
    module.subnet_rds_priv_1b.subnet_id
  ]

  subnet_group_name = "tf-main"

  tags_subnet_group = {
    Name = "My tf-DB subnet group"
    Kind = "Practice"
  }
}

# RDS Module
module "db" {
  source                  = "./modules/rds"
  identifier_name         = "tf-db"
  allocated_storage       = 10
  db_name                 = "mydb"
  username                = "rt"
  vpc_security_group_ids  = [module.sg_rds.sg_id]
  subnet_group_name       = module.db_subnet_group.subnet_group_id
  storage_encrypted       = false

  tags_rds = {
    Name = "tf-db"
    Kind = "practice"
  }
}
