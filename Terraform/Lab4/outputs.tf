output "transactions_topic_arn" {
  description = "ARN of the transactions notification topic"
  value       = aws_sns_topic.transactions.arn
}

output "fraud_alerts_topic_arn" {
  description = "ARN of the fraud alerts topic"
  value       = aws_sns_topic.fraud_alerts.arn
}

output "system_alerts_topic_arn" {
  description = "ARN of the system alerts topic"
  value       = aws_sns_topic.system_alerts.arn
}

