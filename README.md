# terraform-aws-modules

Reusable Terraform modules for AWS. Currently one module is published; more will be added as they are built and validated.

| Module | Description |
|--------|-------------|
| [`efs`](modules/efs) | Amazon EFS file system with mount targets across subnets and an NFS security group |

## Usage

```hcl
module "efs" {
  source = "github.com/yagyandatta/terraform-aws-modules//modules/efs"

  vpc_id            = "vpc-xxxxxxxx"
  default_subnet_id = ["subnet-aaaa", "subnet-bbbb"]
  creation_token    = "project-efs"
  tags = {
    Environment = "dev"
  }
}
```

See [`modules/efs/README.md`](modules/efs/README.md) for inputs and outputs.

## CI

A GitHub Actions workflow (`.github/workflows/validate.yml`) runs `terraform validate` on every module on pull requests and pushes to `dev` and `main`.

## Requirements

- Terraform 1.6+
- AWS provider
