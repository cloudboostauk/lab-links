terraform {
  required_version = ">= 1.5.0"

  backend "local" {
    path = "terraform-dev.tfstate"
  }
}

module "quickshop_dev" {
  source       = "../../modules/app-environment"
  aws_region   = "eu-west-2"         # change to your region
  environment  = "dev"
  instance_type = "t2.micro"
  app_name     = "quickshop"
  key_name     = "quickshop-key"     # existing key pair name
}
