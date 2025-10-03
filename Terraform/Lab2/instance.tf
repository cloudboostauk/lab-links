resource "aws_instance" "cba_tf_instance" {
  ami             = data.aws_ssm_parameter.instance_ami.value
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.cba_public.id
  security_groups = [aws_security_group.cba_tf_sg.id]
  key_name        = var.key_name
  user_data       = fileexists("install_apache.sh") ? file("install_apache.sh") : null


  tags = {
    "NAME" = "ApacheInstance"
  }

}