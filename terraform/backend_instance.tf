resource "aws_instance" "backend" {
  ami                    = var.aws_ami
  instance_type          = var.aws_instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

##auto install
  user_data = file("scripts/deploy_backend.sh")

  tags = {
    Name = "epikra-instance"
  }
}
