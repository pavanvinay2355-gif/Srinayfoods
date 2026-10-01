output "ec2_elastic_ip" {
  description = "Permanent public IP of your backend server — use this in app.js and for SSH"
  value       = aws_eip.app_eip.public_ip
}

output "rds_endpoint" {
  description = "RDS endpoint — use this as DB_HOST in your backend .env file"
  value       = aws_db_instance.godavari_db.address
}

output "s3_bucket_name" {
  description = "S3 bucket name — upload your frontend files here"
  value       = aws_s3_bucket.frontend.bucket
}

output "cloudfront_domain" {
  description = "CloudFront's default domain — your site works here even before DNS finishes propagating"
  value       = aws_cloudfront_distribution.frontend.domain_name
}

output "website_url" {
  description = "Your final live site URL"
  value       = "https://${var.www_domain_name}"
}

output "api_url" {
  description = "Your final live API base URL — use this as API_BASE_URL in app.js"
  value       = "http://${var.api_subdomain}.${var.domain_name}:5000"
}

output "ssh_command" {
  description = "Command to SSH into your server"
  value       = "ssh -i ${var.key_pair_name}.pem ec2-user@${aws_eip.app_eip.public_ip}"
}
