terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Main provider — used for EC2, RDS, S3, Route 53
provider "aws" {
  region = var.aws_region
}

# CloudFront's SSL certificates (ACM) MUST be requested in us-east-1,
# regardless of which region everything else lives in. This alias
# provider guarantees that even if aws_region is ever changed.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
