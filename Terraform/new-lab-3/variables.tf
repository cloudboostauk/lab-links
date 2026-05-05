variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,80}$", var.queue_name))
    error_message = "Queue name must be 1-80 characters, alphanumeric with hyphens/underscores."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be: dev, staging, or prod."
  }
}

variable "message_retention_seconds" {
  description = "How long messages are kept in the queue"
  type        = number
  default     = 345600
}

variable "visibility_timeout_seconds" {
  description = "How long a message is hidden after being received"
  type        = number
  default     = 30
}

variable "enable_dlq" {
  description = "Enable Dead Letter Queue for failed messages"
  type        = bool
  default     = true
}

variable "max_receive_count" {
  description = "Number of times a message can be received before going to DLQ"
  type        = number
  default     = 3
}
