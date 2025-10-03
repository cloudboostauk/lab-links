
variable "region" {
  default = "eu-west-2"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "instance_ami" {
  default = "replace with a linux ami id from your aws console"
}

variable "vpc_id" {
  default = ""
}

variable "key_name" {
  default = "replace with a key-pair name from your aws console"
}