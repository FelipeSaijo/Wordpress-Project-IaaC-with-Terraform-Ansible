#----------------------------------------------------------
# VPC
#----------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block       = var.vpc-CIDR-block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC Project"
  }
}

#----------------------------------------------------------
# Internet Gateway
#----------------------------------------------------------
resource "aws_internet_gateway" "IG_Project" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet Gateway Project"
  }
}

#----------------------------------------------------------
# Public Subnet
#----------------------------------------------------------
resource "aws_subnet" "Public_A" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.sb-CIDR-pub-A
  availability_zone = var.AZ-1a

  tags = {
    Name = "Public Subnet A"
  }
}

resource "aws_subnet" "Public_B" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.sb-CIDR-pub-B
  availability_zone = var.AZ-1b

  tags = {
    Name = "Public Subnet B"
  }
}

#----------------------------------------------------------
# Security Group
#----------------------------------------------------------
resource "aws_security_group" "SG_EC2" {
  name        = var.name-ec2-security-group
  description = "Allow SSH/HTTP/HTTPS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Access HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "Access HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "Access SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "Access SQL"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.Public_A.cidr_block, aws_subnet.Public_B.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.Public_A.cidr_block, aws_subnet.Public_B.cidr_block]
  }

  tags = {
    Name = "Allow SSH/HTTP/HTTPS/SQL Access"
  }
}

resource "aws_security_group" "SG_RDS" {
  name        = var.name-rds-security-group
  description = "Allow SQL inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Access SQL"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.Public_A.cidr_block, aws_subnet.Public_B.cidr_block]
 }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.Public_A.cidr_block, aws_subnet.Public_B.cidr_block]
  }

  tags = {
    Name = "Allow SQL Access"
  }
}

#----------------------------------------------------------
# Public Route Table
#----------------------------------------------------------
resource "aws_route_table" "Public_Route_Table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public Route Table"
  }
}

#----------------------------------------------------------
# Public Route
#----------------------------------------------------------

resource "aws_route" "Public_Route" {
  route_table_id         = aws_route_table.Public_Route_Table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IG_Project.id
}

#----------------------------------------------------------
# Public Association
#----------------------------------------------------------
resource "aws_route_table_association" "Public_A_Association" {
  subnet_id      = aws_subnet.Public_A.id
  route_table_id = aws_route_table.Public_Route_Table.id
}

resource "aws_route_table_association" "Public_B_Association" {
  subnet_id      = aws_subnet.Public_B.id
  route_table_id = aws_route_table.Public_Route_Table.id
}
