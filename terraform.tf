terraform {
    required_version = ">=1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~>3.5.0"
    }
  }
}