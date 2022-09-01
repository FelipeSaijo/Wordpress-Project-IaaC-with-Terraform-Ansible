#----------------------------------------------------------
# Region
#----------------------------------------------------------

variable "region" {
  default = "us-east-1"
}

variable "AZ-1a" {
  default = "us-east-1a"
}

variable "AZ-1b" {
  default = "us-east-1b"
}

#----------------------------------------------------------
# Pivate Key
#----------------------------------------------------------

variable "private-key" {
  default = ""
}

#----------------------------------------------------------
# EC2 Instance
#----------------------------------------------------------

variable "ami-version" {
  default = "ami-090fa75af13c156b4"
}

variable "instance-type" {
  default = "t2.micro"
}

#----------------------------------------------------------
# Database
#----------------------------------------------------------

variable "db-itentifier" {
  default = "wordpress-db"
}

variable "db-engine" {
  default = "mysql"
}

variable "db-engine-version" {
  default = "5.7"
}

variable "db-instance" {
  default = "db.t3.micro"
}

variable "db-name" {
  default = "wordpress"
}

variable "db-username" {
  default = "Admin"
}

variable "db-password" {
  default = "Admin123456"
}

variable "db-port" {
  default = "3306"
}

variable "db-storage-type" {
  default = "gp2"
}

variable "db-allocated-storage" {
  default = 20
}

#----------------------------------------------------------
# VPC
#----------------------------------------------------------

variable "vpc-CIDR-block" {
  default = "10.132.0.0/16"
}

variable "sb-CIDR-pub-A" {
  default = "10.132.1.0/24"
}

variable "sb-CIDR-pub-B" {
  default = "10.132.2.0/24"
}

variable "name-ec2-security-group" {
  default = "EC2-Security-Group"
}

variable "name-rds-security-group" {
  default = "RDS-Security-Group"
}
