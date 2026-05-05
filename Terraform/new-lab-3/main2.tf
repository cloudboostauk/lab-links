terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "orders_queue" {
  source = "../../modules/sqs-queue"

  queue_name                 = "snapcart-orders"
  environment                = "dev"
  message_retention_seconds  = 86400
  visibility_timeout_seconds = 60
  enable_dlq                 = true
  max_receive_count          = 3
}

module "notifications_queue" {
  source = "../../modules/sqs-queue"

  queue_name                 = "snapcart-notifications"
  environment                = "dev"
  message_retention_seconds  = 86400
  visibility_timeout_seconds = 30
  enable_dlq                 = true
}

output "orders_queue_url" {
  value = module.orders_queue.queue_url
}

output "notifications_queue_url" {
  value = module.notifications_queue.queue_url
}
