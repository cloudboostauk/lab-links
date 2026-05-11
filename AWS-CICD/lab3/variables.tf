variable "aws_region" {
  description = "eu-west-2"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "quickshop"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
}
