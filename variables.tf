variable "aws_region" {
  description = "AWS region for all resources (must be us-east-1 for CloudFront/ACM to work cleanly)"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Short name used to tag/name resources"
  type        = string
  default     = "godavari-foods"
}

variable "domain_name" {
  description = "Your root domain, e.g. srinayfoods.in"
  type        = string
  default     = "srinayfoods.in"
}

variable "www_domain_name" {
  description = "The www subdomain, e.g. www.srinayfoods.in"
  type        = string
  default     = "www.srinayfoods.in"
}

variable "api_subdomain" {
  description = "Subdomain used for the backend API, e.g. api"
  type        = string
  default     = "api"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for RDS. Pass this via terraform.tfvars or -var, never commit it."
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database schema name"
  type        = string
  default     = "godavari_foods"
}

variable "my_ip_cidr" {
  description = "Your own IP address in CIDR form, e.g. 103.99.8.136/32 — get it from whatismyip.com. Used to allow SSH and direct DB access."
  type        = string
}

variable "key_pair_name" {
  description = "Name of an EXISTING EC2 key pair (create it in the AWS Console first: EC2 > Key Pairs > Create key pair). Terraform will not create the .pem file for you."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS instance size"
  type        = string
  default     = "db.t3.micro"
}
