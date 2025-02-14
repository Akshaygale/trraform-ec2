provider "aws" {
  region = "us-east-1"
}

/* S3 Bucket */
resource "aws_s3_bucket" "s3resource" {
  bucket = "meri-nani-ki-balti"
}

/* EC2 Instance */
resource "aws_instance" "ec2-resource" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allowSG.name]

  tags = {
    Name = "terra-demo"
  }
}

/* Default VPC */
resource "aws_default_vpc" "default" {}

/* Security Group */
resource "aws_security_group" "allowSG" {
  name        = "allow TLS"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "port 22 allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 80 allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysecurity"
  }
}
