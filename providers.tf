terraform {
  backend "s3" {
    bucket         = "jogesh-deployment-terraform-state-2d9f8a4e"  # Replace with your bucket name
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table-0e2f2751"  # For state locking
  }
}

provider "aws" {
  region = "us-east-1"
}