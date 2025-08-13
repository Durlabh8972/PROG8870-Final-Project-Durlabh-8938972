# terraform.tfvars - example values (DO NOT commit real secrets)

aws_region          = "us-east-1"
instance_type       = "t3.micro"
key_name            = "Durlabh8972-key"
public_key_path = "C:/Users/tilav/.ssh/id_rsa.pub"
db_name             = "durlabh8972db"
db_username         = "adminuser"
db_password         = "ChangeMe123!"   # Replace with a strong password in practice
enable_s3_versioning = true
my_ip_cidr          = "192.168.1.100/32"  # Replace with your real IP for SSH security
