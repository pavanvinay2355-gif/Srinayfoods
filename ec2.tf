# Latest Amazon Linux 2023 AMI, looked up automatically (no hardcoded AMI ID to go stale)
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  # Installs Node.js, git, and pm2 automatically on first boot.
  # Your actual app code still needs to be copied over with scp (see DEPLOY_STEPS.md) —
  # Terraform provisions infrastructure, not your application code.
  user_data = <<-EOF
    #!/bin/bash
    dnf install -y nodejs git
    npm install -g pm2
  EOF

  tags = { Name = "${var.project_name}-app-server" }
}

# A permanent public IP that never changes, even if the instance restarts.
resource "aws_eip" "app_eip" {
  instance = aws_instance.app_server.id
  domain   = "vpc"

  tags = { Name = "${var.project_name}-eip" }
}
