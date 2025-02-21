locals {
	region = "us-east-2"
}

terraform {
	backend "s3" {
    bucket = "terraform-state-avjju1z2"
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
