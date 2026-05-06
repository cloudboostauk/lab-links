locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_sns_topic" "transactions" {
  name = "${local.name_prefix}-transactions"

  kms_master_key_id = var.enable_encryption ? "alias/aws/sns" : null

  tags = {
    Name        = "${local.name_prefix}-transactions"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform-cloud"
    Purpose     = "transaction-alerts"
  }
}

resource "aws_sns_topic" "fraud_alerts" {
  name = "${local.name_prefix}-fraud-alerts"

  kms_master_key_id = var.enable_encryption ? "alias/aws/sns" : null

  tags = {
    Name        = "${local.name_prefix}-fraud-alerts"
    Environment = var.environment
    Purpose     = "security-alerts"
    Critical    = "true"
  }
}

resource "aws_sns_topic" "system_alerts" {
  name = "${local.name_prefix}-system-alerts"

  kms_master_key_id = var.enable_encryption ? "alias/aws/sns" : null

  tags = {
    Name        = "${local.name_prefix}-system-alerts"
    Environment = var.environment
    Purpose     = "infrastructure-monitoring"
  }
}