#----------------------------------------------------------
# DataBase
#----------------------------------------------------------
resource "aws_db_instance" "db_postgresql" {
  identifier                = var.db-itentifier
  engine                    = var.db-engine
  engine_version            = var.db-engine-version
  instance_class            = var.db-instance
  db_name                   = var.db-name
  username                  = var.db-username
  password                  = var.db-password
  port                      = var.db-port
  storage_type              = var.db-storage-type
  allocated_storage         = var.db-allocated-storage
  vpc_security_group_ids    = [aws_security_group.SG_RDS.id]
  db_subnet_group_name      = aws_db_subnet_group.SG_Database.id
  availability_zone         = var.AZ-1a
  publicly_accessible       = true
  skip_final_snapshot       = true

  tags = {
    Name = "RDS DB Instance"
  }
}

resource "aws_db_subnet_group" "SG_Database" {
  name       = "sg-database"
  subnet_ids = [aws_subnet.Public_A.id, aws_subnet.Public_B.id]

  tags = {
    Name = "DB Subnet Group"
  }
}