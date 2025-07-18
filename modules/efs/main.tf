#---------------------------------------------#
# AWS EFS Module
# Author: Yagyandatta Murmu
#---------------------------------------------#

# required Version
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_efs_file_system" "this" {
  creation_token         = var.creation_token
  encrypted              = var.encrypted
  availability_zone_name = var.availability_zone_name
  performance_mode       = "generalPurpose"
  throughput_mode        = "bursting"

  tags = merge({
    Name = "efs-${var.creation_token}"
  }, var.tags)
}

resource "aws_security_group" "efs_sg" {
  name        = "efs-${var.creation_token}-sg"
  description = "Allow NFS access to EFS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "efs-${var.creation_token}-sg"
  }, var.tags)
}

resource "aws_efs_mount_target" "this" {
  for_each = toset(var.default_subnet_id)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs_sg.id]

  # Creates a mount target in each subnet (must be in different AZs)
}
