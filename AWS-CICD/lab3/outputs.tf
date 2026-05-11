output "instance_id" {
  value       = aws_instance.this.id
  description = "ID of the EC2 instance"
}

output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP of the EC2 instance"
}

output "name_tag" {
  value       = aws_instance.this.tags["Name"]
  description = "Name tag of the EC2 instance"
}
