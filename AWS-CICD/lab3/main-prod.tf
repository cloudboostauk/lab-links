terraform {
  required_version = ">= 1.5.0"

  backend "local" {
    path = "terraform-prod.tfstate"
  }
}

module "quickshop_prod" {
  source       = "../../modules/app-environment"
  aws_region   = "eu-west-2"       # same region for this lab
  environment  = "prod"
  instance_type = "t3.small"       # slightly bigger instance for prod
  app_name     = "quickshop"
  key_name     = "quickshop-key"   # same key pair
}
