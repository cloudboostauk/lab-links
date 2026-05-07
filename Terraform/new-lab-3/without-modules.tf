# ──────────────────────────────────────────────────
# Team Alpha — orders + notifications queues
# main.tf  (90 lines for just 2 queues)
# ──────────────────────────────────────────────────
 
provider "aws" {
  region = "eu-west-2"
}
 
# Dead-letter queue for orders
resource "aws_sqs_queue" "orders_dlq" {
  name                        = "alpha-orders-dev-dlq"
  message_retention_seconds   = 1209600
  sqs_managed_sse_enabled     = true
  tags = { Team = "alpha", Environment = "dev" }
}
 
# Main orders queue
resource "aws_sqs_queue" "orders" {
  name                       = "alpha-orders-dev"
  message_retention_seconds  = 86400
  visibility_timeout_seconds = 60
  sqs_managed_sse_enabled    = true
 
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.orders_dlq.arn
    maxReceiveCount     = 3
  })
  tags = { Team = "alpha", Environment = "dev" }
}
 
# Dead-letter queue for notifications
resource "aws_sqs_queue" "notifications_dlq" {
  name                        = "alpha-notifications-dev-dlq"
  message_retention_seconds   = 1209600
  sqs_managed_sse_enabled     = true
  tags = { Team = "alpha", Environment = "dev" }
}
 
# Main notifications queue
resource "aws_sqs_queue" "notifications" {
  name                       = "alpha-notifications-dev"
  message_retention_seconds  = 86400
  visibility_timeout_seconds = 60
  sqs_managed_sse_enabled    = true
 
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.notifications_dlq.arn
    maxReceiveCount     = 3
  })
  tags = { Team = "alpha", Environment = "dev" }
}
