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
  environment                = "prod"
  message_retention_seconds  = 1209600
  visibility_timeout_seconds = 300
  enable_dlq                 = true
  max_receive_count          = 5
}

output "orders_queue_arn" {
  value = module.orders_queue.queue_arn
}