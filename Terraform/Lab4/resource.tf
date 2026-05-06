resource "aws_sns_topic" "compliance" {
  name = "${local.name_prefix}-compliance"

  kms_master_key_id = var.enable_encryption ? "alias/aws/sns" : null

  tags = {
    Name        = "${local.name_prefix}-compliance"
    Environment = var.environment
    Purpose     = "regulatory-compliance"
    Critical    = "true"
  }
}