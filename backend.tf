terraform {
  backend "s3" {
    bucket = "arslan-terraform-state-2026-devops"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}