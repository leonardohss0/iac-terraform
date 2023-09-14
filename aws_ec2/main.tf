# Create RSA key of size 4096 bits
resource "tls_private_key" "tf_ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create local file
resource "local_file" "tf_ec2_key" {
  content  = tls_private_key.tf_ec2_key.private_key_pem
  filename = "${path.module}/tf_ec2_key.pem"
}

# Create AWS key pair
resource "aws_key_pair" "tf_ec2_key" {
  key_name   = "tf_ec2_key"
  public_key = tls_private_key.tf_ec2_key.public_key_openssh
}

# EC2 instance Security Group
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow SSH and HTTP/HTTPS inbound traffic"

  # Allow SSH inbound for allowed IP addresses
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.security_group_ids
  }

  # TCP port 80 for HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # TCP port 443 for HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound HTTP to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound HTTPS to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create AWS EC2 instance
resource "aws_instance" "example" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tf_ec2_key.key_name           # Name of the created Key Pair
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id] # Created SecGroup

  tags = {
    Name = "demo-terraform" # This sets the name tag to "demo-terraform"
  }
}