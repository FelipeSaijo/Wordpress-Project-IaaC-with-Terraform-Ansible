terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

#----------------------------------------------------------
# EC2 Instance Wordpress
#----------------------------------------------------------

resource "aws_instance" "Wordpress_Instance" {
    ami                         = var.ami-version
    instance_type               = var.instance-type
    availability_zone           = var.AZ-1a
    key_name                    = var.private-key
    subnet_id                   = aws_subnet.Public_A.id
    vpc_security_group_ids      = [aws_security_group.SG_EC2.id]
    associate_public_ip_address = true
    
    tags = {
        Name = "Wordpress Amazon Linux"
    }
}
