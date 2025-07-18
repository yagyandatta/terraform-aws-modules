# terraform-aws-efs

Terraform module to create and configure **Amazon Elastic File System (EFS)** with mount targets and security group.

## Features

- Creates EFS filesystem
- Creates mount targets in multiple subnets
- Creates security group allowing NFS access
- Configurable encryption and zone placement

## Usage

```hcl
module "efs" {
  source = "../../"

  vpc_id            = "vpc-xxxxxx"
  default_subnet_id = ["subnet-aaaa", "subnet-bbbb"]
  creation_token    = "project-efs"
  tags = {
    Environment = "dev"
    Owner       = "yagyandatta"
  }
}
