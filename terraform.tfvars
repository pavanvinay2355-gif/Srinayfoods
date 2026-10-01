# Copy this file to terraform.tfvars and fill in your real values.
# NEVER commit terraform.tfvars (it contains your DB password) to git.

aws_region      = "us-east-1"
domain_name     = "srinayfoods.in"
www_domain_name = "www.srinayfoods.in"

db_username = "admin"
db_password = "Vinay2355"
db_name     = "godavari_foods"

# Get your current IP from https://whatismyip.com and add /32 at the end
my_ip_cidr = "106.192.24.211/32"

# Must already exist: EC2 Console -> Key Pairs -> Create key pair (download the .pem)
key_pair_name = "godavari-key"
