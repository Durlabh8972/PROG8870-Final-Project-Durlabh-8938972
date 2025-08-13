# main.tf

# Data source for AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0"

  name = "Durlabh8972-prog8870-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = [
    cidrsubnet(var.vpc_cidr, 8, 10),  # 10.0.10.0/24
    cidrsubnet(var.vpc_cidr, 8, 11),  # 10.0.11.0/24
  ]
  private_subnets = [
    cidrsubnet(var.vpc_cidr, 8, 12),  # 10.0.12.0/24
    cidrsubnet(var.vpc_cidr, 8, 13),  # 10.0.13.0/24
  ]

  enable_dns_hostnames = true
  enable_dns_support   = true
}

# AMI lookup
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "Durlabh8972-key"
  public_key = file(var.public_key_path)
}

# Security Group for SSH
resource "aws_security_group" "ssh" {
  name        = "Durlabh8972-allow_ssh"
  description = "Allow SSH inbound"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.ssh.id]

  tags = {
    Name        = "Durlabh8972-prog8870-web"
    Owner       = "Durlabh8972"
    Project     = "prog8870"
    Student_ID  = "8972"
  }
}

# S3 Buckets
resource "aws_s3_bucket" "app_buckets" {
  for_each = toset([
    "durlabh8972-prog8870-bucket-1",
    "durlabh8972-prog8870-bucket-2",
    "durlabh8972-prog8870-bucket-3",
    "durlabh8972-prog8870-bucket-4"
  ])
  bucket = each.value
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  for_each = aws_s3_bucket.app_buckets
  bucket   = each.value.id
  versioning_configuration {
    status = var.enable_s3_versioning ? "Enabled" : "Suspended"
  }
}

# Block public access (AWS Provider 6.x compliant)
resource "aws_s3_bucket_public_access_block" "public_access" {
  for_each                = aws_s3_bucket.app_buckets
  bucket                  = each.value.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DB Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = "durlabh8972-prog8870-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name       = "durlabh8972-prog8870-db-subnet-group"
    Owner      = "Durlabh8972"
    Student_ID = "8972"
  }
}

# RDS Security Group
resource "aws_security_group" "rds" {
  name   = "durlabh8972-allow_mysql"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ssh.id]
    description     = "Allow MySQL from web security group"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Instance
resource "aws_db_instance" "mysql" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name       = "durlabh8972-prog8870-mysql"
    Owner      = "Durlabh8972"
    Student_ID = "8972"
  }
}
