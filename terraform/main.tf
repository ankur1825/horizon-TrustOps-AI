terraform {
  #required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.20.0.0/16"

  azs            = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets = ["10.20.1.0/24", "10.20.2.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false

  map_public_ip_on_launch = true

  tags = {
    Environment = "dev"
    Project     = "horizon"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    dev_node_group = {
      name = "dev-node-group"

      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.xlarge"]

      min_size     = 1
      max_size     = 2
      desired_size = 1

      disk_size = 20

      labels = {
        environment = "dev"
      }
    }
  }

  tags = {
    Environment = "dev"
    Project     = "horizon"
  }
}