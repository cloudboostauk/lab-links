resource "aws_instance" "cba_tf_instance" {
  instance_type = var.instance_type
  security_groups = [aws_security_group.cba_tf_sg.name]
  ami = var.instance_ami
  key_name = var.key_name

  tags = {
    Name = "CBATerraformInstance"
    }
}