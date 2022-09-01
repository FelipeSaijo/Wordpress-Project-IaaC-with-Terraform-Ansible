#----------------------------------------------------------
# Outputs
#----------------------------------------------------------

output "EC2-Instance-Public-IP" {
  value = aws_instance.Wordpress_Instance.public_ip
}

output "RDS-endpoint" {
  value = aws_db_instance.db_postgresql.endpoint
}
