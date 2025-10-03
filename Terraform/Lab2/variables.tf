variable "region" {
  default = "us-west-2" # Change to prefered location
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "test-keypair"
}