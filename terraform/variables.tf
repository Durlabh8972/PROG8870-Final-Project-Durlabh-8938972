variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "Durlabh8972-key"
}

variable "public_key_path" {
  description = "Path to public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "durlabh8972db"
}

variable "db_username" {
  description = "DB username"
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "DB password (do not commit real secrets)"
  type        = string
  default     = "ChangeMe123!"
}

variable "enable_s3_versioning" {
  description = "Enable versioning on S3 buckets"
  type        = bool
  default     = false
}

variable "my_ip_cidr" {
  description = "Your current public IP in CIDR format to allow SSH (e.g. 1.2.3.4/32)"
  type        = string
  default     = "0.0.0.0/0"
}
