# Terraform AWS Modules

A comprehensive collection of reusable Terraform modules for AWS infrastructure provisioning. This repository contains well-structured, production-ready modules that follow AWS and Terraform best practices.

## Overview

This repository provides a centralized collection of Terraform modules for common AWS services and infrastructure patterns. Each module is designed to be:

- **Reusable**: Can be used across multiple projects and environments
- **Configurable**: Supports various configuration options through variables
- **Secure**: Implements AWS security best practices by default
- **Well-documented**: Includes comprehensive documentation and examples
- **Tested**: Thoroughly tested for reliability and compatibility

## Repository Structure

```
terraform-aws-modules/
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── rds/
│   ├── s3/
│   ├── iam/
│   ├── lambda/
│   ├── eks/
│   ├── alb/
│   └── ...
├── examples/
│   ├── complete-infrastructure/
│   ├── vpc-with-subnets/
│   └── ...
├── docs/
├── tests/
└── README.md
```

## Available Modules

### Networking
- **VPC** - Virtual Private Cloud with subnets, route tables, and gateways
- **ALB** - Application Load Balancer with target groups and listeners
- **NLB** - Network Load Balancer configuration
- **Security Groups** - Configurable security group rules

### Compute
- **EC2** - Elastic Compute Cloud instances with auto-scaling
- **ECS** - Elastic Container Service clusters and services
- **EKS** - Elastic Kubernetes Service clusters
- **Lambda** - Serverless function deployment

### Storage
- **S3** - Simple Storage Service buckets with policies
- **EBS** - Elastic Block Store volumes
- **EFS** - Elastic File System

### Database
- **RDS** - Relational Database Service instances
- **DynamoDB** - NoSQL database tables
- **ElastiCache** - In-memory caching service

### Security & Identity
- **IAM** - Identity and Access Management roles and policies
- **KMS** - Key Management Service for encryption
- **Secrets Manager** - Secure secret storage

### Monitoring & Logging
- **CloudWatch** - Monitoring and alerting
- **CloudTrail** - API logging and auditing

## Quick Start

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- Basic understanding of Terraform and AWS services

### Using a Module

1. **Reference the module in your Terraform configuration:**

```hcl
module "vpc" {
  source = "git::https://github.com/yourusername/terraform-aws-modules.git//modules/vpc"
  
  name               = "my-vpc"
  cidr               = "10.0.0.0/16"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
  enable_nat_gateway = true
  enable_vpn_gateway = false
  
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

2. **Initialize and apply:**

```bash
terraform init
terraform plan
terraform apply
```

### Example: Complete Infrastructure

```hcl
# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  name               = "production-vpc"
  cidr               = "10.0.0.0/16"
  availability_zones = ["us-west-2a", "us-west-2b"]
  
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  
  enable_nat_gateway = true
  
  tags = local.common_tags
}

# Security Group Module
module "web_security_group" {
  source = "./modules/security-group"
  
  name   = "web-sg"
  vpc_id = module.vpc.vpc_id
  
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  
  tags = local.common_tags
}

# EC2 Module
module "web_servers" {
  source = "./modules/ec2"
  
  name          = "web-server"
  instance_type = "t3.medium"
  key_name      = "my-key-pair"
  
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnets
  security_group_ids      = [module.web_security_group.security_group_id]
  
  min_size         = 2
  max_size         = 10
  desired_capacity = 3
  
  tags = local.common_tags
}
```

## Module Documentation

Each module includes detailed documentation with:

- **Purpose and use cases**
- **Input variables** with descriptions and types
- **Output values** that can be referenced
- **Usage examples**
- **Requirements** (Terraform version, AWS provider version)

Navigate to individual module directories for specific documentation:

- [VPC Module](./modules/vpc/README.md)
- [EC2 Module](./modules/ec2/README.md)
- [RDS Module](./modules/rds/README.md)
- [S3 Module](./modules/s3/README.md)

## Best Practices

### Module Design
- Follow the standard module structure with `main.tf`, `variables.tf`, and `outputs.tf`
- Use meaningful variable names and descriptions
- Provide sensible defaults where appropriate
- Include validation rules for input variables

### Security
- Enable encryption by default
- Use least privilege principles for IAM roles
- Implement proper network segmentation
- Regular security reviews and updates

### Tagging
- Implement consistent tagging strategy
- Include required tags: Environment, Project, Owner
- Support custom tags through variables

### Versioning
- Use semantic versioning for releases
- Tag releases for stable module versions
- Maintain backward compatibility when possible

## Contributing

We welcome contributions to improve and expand this module collection!

### Development Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/terraform-aws-modules.git
cd terraform-aws-modules
```

2. Install development dependencies:
```bash
# Install pre-commit hooks
pre-commit install

# Install testing tools
pip install terratest pytest
```

### Contribution Guidelines

1. **Fork the repository** and create a feature branch
2. **Follow the module structure** and naming conventions
3. **Include comprehensive documentation** and examples
4. **Add or update tests** for your changes
5. **Run tests** to ensure everything works correctly
6. **Submit a pull request** with clear description

### Code Standards

- Use consistent formatting with `terraform fmt`
- Validate configuration with `terraform validate`
- Follow naming conventions for resources and variables
- Include appropriate comments and documentation

## Testing

### Local Testing

```bash
# Format code
terraform fmt -recursive

# Validate configuration
terraform validate

# Run security checks
checkov -d ./modules

# Run tests
cd tests
go test -v
```

### Automated Testing

This repository includes:
- **GitHub Actions** for CI/CD pipeline
- **Terratest** for infrastructure testing
- **Checkov** for security scanning
- **TFLint** for linting Terraform code

## Versioning

We use [Semantic Versioning](https://semver.org/) for releases:

- **MAJOR** version for incompatible API changes
- **MINOR** version for backwards-compatible functionality
- **PATCH** version for backwards-compatible bug fixes

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Issues**: Report bugs or request features via [GitHub Issues](https://github.com/yagyandatta/terraform-aws-modules/issues)
- **Discussions**: Join discussions in [GitHub Discussions](https://github.com/yagyandatta/terraform-aws-modules/discussions)
- **Documentation**: Check module-specific README files for detailed usage

## Acknowledgments

- AWS for providing comprehensive cloud services
- HashiCorp for developing Terraform
- The open-source community for inspiration and contributions
