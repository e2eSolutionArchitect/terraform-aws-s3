terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

# provider block

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

# terraform {
#   cloud {
#     organization = "demo"

#     workspaces {
#       name = "demo-ws-aws-ec2"
#     }
#   }
# }