locals {
	region = "us-east-2"
}

terraform {
	backend "s3" {
    bucket = "terraform-state-3kcw0h1z"
    key    = "backend"
    region = "us-east-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.region
}
