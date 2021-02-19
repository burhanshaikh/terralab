terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.28.0"
    }
  }
  backend "s3" {
    
    encrypt = true
    bucket = "statebucketalpha"
    dynamodb_table = "statelocking"
    key = "terraform/state.tf"
    region = "us-east-1"
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}