terraform {
  required_version = ">= 1.6.0"

  cloud {
    organization = "YOUR_ORG_NAME"

    workspaces {
      tags = ["finovo"]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
