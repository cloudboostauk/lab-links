variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "app_name" {
  description = "Application name used across resource names"
  type        = string
  default     = "quickshop"
}

variable "container_port" {
  description = "Port the Flask app listens on inside the container"
  type        = number
  default     = 5000
}

variable "task_cpu" {
  description = "Fargate task CPU units (256 = 0.25 vCPU)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Fargate task memory in MiB"
  type        = number
  default     = 512
}
